---
title: "【Shader学习】边缘光和流光特效(六十二)"
subtitle: "边缘光和流光特效(六十二)"
date: 2021-02-09T19:31:05+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
draft: true
tags: [“Shader学习”]
categories: [“Shader”]
---

<!--more-->
##  边缘光和流光特效
'''c
Shader "Unlit/EdgeAndScan"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_PowEmiss("Pow Emiss",float)=5
		_RimMin("RimMin",Range(-1,1)) = 0.0
		_RimMax("RimMax",Range(0,2)) = 1.0
		_InnerColor("Inner Color",Color) = (0.0,0.0,0.0,0.0)
		_RimColor("Rim Color",Color) = (1,1,1,1)
		_RimIntensity("Rim Intensity",Float) = 1.0
		_FlowTilling("Flow Tilling",Vector) = (1,1,0,0)
		_FlowSpeed("Flow Speed",Vector) = (1,1,0,0)
		_FlowTex("Flow Tex",2D) = "white"{}
		_FlowIntensity("Flow Intensity",Float) = 0.5
	}
	SubShader
	{
		Tags { "Queue"="Transparent" }
		LOD 100

		Pass {
			//这个Pass不输出颜色，只是输出深度，透明会有问题，如果不处理深度
			//只是测试流光和边缘光可以删除该pass
			Cull Off 
			ZWrite On 
			ColorMask 0
			CGPROGRAM
			float4 _Color;
			#pragma vertex vert 
			#pragma fragment frag

			float4 vert(float4 vertexPos : POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(vertexPos);
			}

			float4 frag(void) : COLOR
			{
				return _Color;
			}
			ENDCG
		}

		Pass
		{
			ZWrite Off
			Blend SrcAlpha One
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal: NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 world_normal: TEXCOORD1;
				float3 world_pos: TEXCOORD2;
				float3 world_pivot:TEXCOORD3;
				
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _RimMin;
			float _RimMax;
			float4 _InnerColor;
			float4 _RimColor;
			float _RimIntensity;
			float4 _FlowTilling;
			float4 _FlowSpeed;
			sampler2D _FlowTex;
			float _FlowIntensity;
			float _InnerAlpha;
			float _PowEmiss;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.world_normal=normalize(mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
				o.world_pos=mul(unity_ObjectToWorld,float4(v.vertex.xyz,1)).xyz;
				o.world_pivot=mul(unity_ObjectToWorld,float4(0,0,0,1)).xyz;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//边缘光

				half3 world_normal=normalize(i.world_normal);
				float3 world_view=normalize(_WorldSpaceCameraPos.xyz-i.world_pos);
				float dotV=saturate(dot(world_normal,world_view));
				float fresnel=1-dotV;
				fresnel = smoothstep(_RimMin, _RimMax, fresnel);
				//用于增加细节，也可以不要
				half emiss = tex2D(_MainTex, i.uv).r;
				emiss = pow(emiss, _PowEmiss);
				float final_edge_alpha=saturate(emiss+fresnel);
				float3 final_edge_col=lerp(_InnerColor.xyz, _RimColor.xyz * _RimIntensity, final_edge_alpha);
				
				//流光
				float2 flow_uv=(i.world_pos.xy-i.world_pivot.xy)*_FlowTilling.xy;
				flow_uv=_Time.y*_FlowSpeed.xy+flow_uv;
				float4 flow_col=tex2D(_FlowTex,flow_uv)*_FlowIntensity;

				//合并
				float3 final_col=final_edge_col+flow_col.rgb;
				float final_alpha=saturate(final_edge_alpha+flow_col.a);
				return float4(final_col.rgb,final_alpha);
			}
			ENDCG
		}
	}
}

'''

材质球属性：  
![20210209195436](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader学习-1.3边缘光和流光特效/20210209195436.png)  

效果： 

![20210209195607](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader学习-1.3边缘光和流光特效/20210209195607.png)