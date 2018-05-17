using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Print : MonoBehaviour
{

    public int id = 0;
    public string path = "0Right";
    public int diff = 15;

    public GameObject cube;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown("space"))
        {
            if (System.IO.Directory.Exists(path))
            {
                Debug.Log("HEY MEEE!!");
            }
            else
            {
                System.IO.Directory.CreateDirectory("Cubo/" + path);
            }

            ScreenCapture.CaptureScreenshot("Cubo/" + path +"/" + id++ + "_mask.png");
            cube.transform.Rotate(new Vector3(1, 0, 0), diff);
        }

    }
}
