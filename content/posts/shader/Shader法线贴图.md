---
title: "【Shader】 法线贴图"
date: 2019-12-01T21:57:40+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
tags: ["shader"]
categories: ["shader"]
---

<!--more-->

> 法线贴图,在切线空间下计算（Cubemap环境映射不可以用，要用世界空间下计算）
> 参考 《unity shader 入门精要》

```c++
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Book/07.TangentNormal"
{
//法线贴图
	Properties
	{
		_Color ("Color Tint",Color)=(1,1,1,1)
		_MainTex ("Main Tex", 2D) = "white" {}
		_BumpMap("Normal Map",2D) = "white" {}
		_BumpScale("Bump Scale",Float) = 1.0
		_Specular("Specular",Color) = (1,1,1,1)
		_Gloss("Gloss",Range(8.0,256)) = 20
	}
	SubShader
	{

		Pass
		{
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			//#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"


			float4 _Color,_Specular;
			sampler2D _MainTex;
			sampler2D _BumpMap;
			float _BumpScale,_Gloss;

			float4 _MainTex_ST;
			float4 _BumpMap_ST;



			struct a2v
			{
				float4 vertex : POSITION;
				float3 normal: NORMAL;
				float4 tangent:TANGENT;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 uv : TEXCOORD0;
				float3 lightDir:TEXCOORD1;
				float3 viewDir:TEXCOORD2;
			};

			
			v2f vert (a2v v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv.xy = v.texcoord.xy*_MainTex_ST.xy + _MainTex_ST.zw;
				o.uv.zw = v.texcoord.xy*_BumpMap_ST.xy + _BumpMap_ST.zw;

				float3 binormal = cross(v.normal,v.tangent.xyz)*v.tangent.w;
				float3x3 rotation = float3x3(v.tangent.xyz,binormal,v.normal);

				//TANGENT_SPACE_ROTATION;

				//将光源位置减去顶点位置，这样就得到光照方向了 — 但是我们应该首先将顶点位置乘上光源的w分量，如果是平行光，w分量为0，得到的结果为0，说明顶点位置全变为(0.0, 0.0, 0.0)了，这样光照方向就是光源本身的位置（return objSpaceLightPos.xyz）。对于点光源，w为1，所以乘上顶点位置后，顶点位置无变化，这样计算的光照方向就是（return objSpaceLightPos.xyz – v.xyz）。
				float3 lightDir = mul(unity_WorldToObject,_WorldSpaceLightPos0).xyz - v.vertex*_WorldSpaceLightPos0.w;
				o.lightDir = mul(rotation,lightDir);
				
				float3 viewDir = mul(unity_WorldToObject,float4(_WorldSpaceCameraPos,1)).xyz-v.vertex.xyz;
				o.viewDir = mul(rotation,viewDir);

				o.viewDir = normalize(o.viewDir);
				o.lightDir = normalize(o.lightDir);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				i.viewDir = normalize(i.viewDir);
				i.lightDir = normalize(i.lightDir);

				//uppack  normal
				fixed3 tangentNormal; 
				fixed4 packedNormal  = tex2D(_BumpMap,i.uv.zw);
				#if defined(UNITY_NO_DXT5nm)
					tangentNormal.xyz = packedNormal.xyz*2 -1;
				#else
					// --rgba  -- xyzw 
					//DXTnm 格式中a通道（即w分量）对应发现x分量,g通道（即y分量）对应发现y分量,
					//tangentNormal.xy = packedNormal.ag*2 -1;
					tangentNormal.xy = packedNormal.wy*2 -1;
					tangentNormal=tangentNormal* _BumpScale;
					tangentNormal.z = sqrt(1.0-max(0,dot(tangentNormal.xy,tangentNormal.xy)));
				#endif
				

				fixed3 albedo = tex2D(_MainTex,i.uv).rgb*_Color.rgb;
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz*albedo;
				fixed3 diffuse = _LightColor0.rgb*albedo*max(0,dot(tangentNormal,i.lightDir));
				fixed3 halfDir = normalize(i.lightDir+i.viewDir);
				fixed3 specular = _LightColor0.rgb*_Specular.rgb*pow(max(0,dot(tangentNormal,halfDir)),_Gloss);
				

				return fixed4(ambient+diffuse+specular,1.0);
			}
			ENDCG
		}
	}
	FallBack "Specular"
}
```