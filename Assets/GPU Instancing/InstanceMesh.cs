using UnityEngine;
using System.Collections;
using UnityEngine.Rendering;

public class InstanceMesh : MonoBehaviour {

    //Attach this script to the object you want to instance, such as a cube object.  It should have a mesh renderer on it.

    Mesh mesh;
    Material mat;

    //Make an empty game object and drag it into the obj variable in the editor.  This object's transform will be used as the transform for the instanced object.
    //public GameObject obj;
    public Vector3 maxPos;
    public int cantidad;

    Matrix4x4[] matrix;
    ShadowCastingMode castShadows;

    public bool turnOnInstance = true;

    void Start() {

        mesh = GetComponent<MeshFilter>().mesh;
        mat = GetComponent<Renderer>().material;
        //matrix = new Matrix4x4[2] { obj.transform.localToWorldMatrix, this.transform.localToWorldMatrix };
        castShadows = ShadowCastingMode.On;


        //Graphics.DrawMeshInstanced(mesh, 0, mat, matrix, matrix.Length, null, castShadows, true, 0, null);

    }

    void Update() {

        if (turnOnInstance) {

            mesh = GetComponent<MeshFilter>().mesh;
            mat = GetComponent<Renderer>().material;
            //matrix = new Matrix4x4[2] { obj.transform.localToWorldMatrix, this.transform.localToWorldMatrix };
            castShadows = ShadowCastingMode.On;

            for(int i = 0; i < cantidad; i++) {
                Vector3 position = new Vector3(Random.Range(-maxPos.x, maxPos.x), Random.Range(-maxPos.y, maxPos.y), Random.Range(-maxPos.z, maxPos.z));
                matrix = new Matrix4x4[2] { GetTRSMatrix(position), this.transform.localToWorldMatrix };
                Graphics.DrawMeshInstanced(mesh, 0, mat, matrix, matrix.Length, null, castShadows, true, 0, null);
            }

            

        }
    }

    public Matrix4x4 GetTRSMatrix(Vector3 position) {
        return Matrix4x4.TRS(transform.localPosition+position, transform.localRotation, transform.localScale);
    }
}