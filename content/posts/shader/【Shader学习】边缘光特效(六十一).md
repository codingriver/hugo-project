---
title: "【Shader学习】边缘光特效(六十一)"
subtitle: "边缘光特效"
date: 2021-02-09T18:29:01+08:00
author: "codingriver"
authorLink: "https://codingriver.github.io"
draft: true
tags: [“Shader学习”]
categories: [“Shader”]
---

<!--more-->
'''c
Shader "Unlit/Edge"
{
	Properties
	{
		_EdgeColor("Edge Color",Color)=(1,1,1,1)
		_RimMin("RimMin",Range(-1,1)) = 0.0
		_RimMax("RimMax",Range(0,2)) = 1.0
	}
	SubShader
	{
		Tags { "Queue"="Transparent" }
		LOD 100
		
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
				
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _EdgeColor;
			float _PowEmiss;
			float _InnerAlpha;
			float _RimMin;
			float _RimMax;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.world_normal=normalize(mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
				o.world_pos=mul(unity_ObjectToWorld,float4(v.vertex.xyz,1)).xyz;
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
				half emiss = tex2D(_MainTex, i.uv).r;
				emiss = pow(emiss, 5.0);
				float final_edge_alpha=saturate(emiss+fresnel);

				//float emiss=pow(fresnel,_PowEmiss);
				//fixed4 col = tex2D(_MainTex, i.uv);
				return float4(_EdgeColor.rgb,fresnel);
			}
			ENDCG
		}
	}
}

'''
材质球面板：
![20210209183036](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader学习-1.2边缘光特效/20210209183036.png)

效果：
![20210209183117](https://cdn.jsdelivr.net/gh/codingriver/cdn/texs/Shader学习-1.2边缘光特效/20210209183117.png)