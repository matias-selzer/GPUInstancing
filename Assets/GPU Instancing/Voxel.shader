Shader "VUE/Voxel Standard Particle" {

    Properties {

        _Color ("Color", Color) = (1,1,1,1)

        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Glossiness ("Smoothness", Range(0,1)) = 0.5

        _Metallic ("Metallic", Range(0,1)) = 0.0

        _ZOffset ("Z Buffer Offset", Float) = 0

    }



    SubShader {

        Tags { "RenderType"="Opaque" }

        LOD 200

        Offset [_ZOffset], [_ZOffset]



        CGPROGRAM

        // Physically based Standard lighting model, and enable shadows on all light types

        // And generate the shadow pass with instancing support

        #pragma surface surf Standard nolightmap nometa noforwardadd keepalpha fullforwardshadows addshadow vertex:vert



        // Enable instancing for this shader

        // See https://docs.unity3d.com/Manual/PartSysInstancing.html for more information about particle instancing.

        #pragma multi_compile_instancing

        #pragma instancing_options procedural:vertInstancingSetup

        #pragma exclude_renderers gles

        #include "UnityStandardParticleInstancing.cginc"



        sampler2D _MainTex;



        struct Input {

            float2 uv_MainTex;

            fixed4 vertexColor;

        };



        fixed4 _Color;

        half _Glossiness;

        half _Metallic;



        void vert (inout appdata_full v, out Input o)

        {

            UNITY_INITIALIZE_OUTPUT(Input, o);

            vertInstancingColor(o.vertexColor);

            vertInstancingUVs(v.texcoord, o.uv_MainTex);

        }



        void surf (Input IN, inout SurfaceOutputStandard o) {

            // Albedo comes from a texture tinted by color

            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * IN.vertexColor * _Color;

            o.Albedo = c.rgb;



            // Metallic and smoothness come from slider variables

            o.Metallic = _Metallic;

            o.Smoothness = _Glossiness;

            o.Alpha = c.a;

        }

        ENDCG

    }



    FallBack "Diffuse"

}
