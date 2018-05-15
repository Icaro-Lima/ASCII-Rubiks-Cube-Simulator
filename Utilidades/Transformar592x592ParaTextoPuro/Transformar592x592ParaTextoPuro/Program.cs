using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Drawing;

namespace Transformar592x592ParaTextoPuro
{
    class Program
    {
        static int Mean(Bitmap image, int i, int j, int cols, int rows)
        {
            int sum = 0, count = 0;
            for (int ii = 0; ii < rows; ii++)
            {
                for (int jj = 0; jj < cols; jj++)
                {
                    if (i + ii >= image.Height || j + jj >= image.Width)
                    {
                        continue;
                    }

                    count++;
                    Color color = image.GetPixel(j + jj, i + ii);
                    sum += (color.R + color.G + color.B) / 3;
                }
            }

            return sum / count;
        }

        static void Process(string path)
        {
            const int blockWidth = 8;
            const int blockHeight = 16;

            Bitmap bitmap = (Bitmap)Image.FromFile(path);


            string concat = "";
            string[][] result = new string[bitmap.Height / 16][];
            for (int i = 0; i < bitmap.Height; i += blockHeight)
            {
                for (int j = 0; j < bitmap.Width; j += blockWidth)
                {
                    concat += Mean(bitmap, i, j, blockWidth, blockHeight) == 255 ? " " : "#";
                }
                concat += "\n";
            }

            using (StreamWriter sw = new StreamWriter(Path.Combine(Path.GetDirectoryName(path), Path.GetFileNameWithoutExtension(path) + ".txt"), false))
            {
                sw.Write(concat);
            }
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Digite o caminho: ");
            string path = @"C:\Users\Lenovo\Documents\Unity\Apenas visualizando o cubo";
            string[] paths = Directory.GetFiles(path, "*.png", SearchOption.AllDirectories);
            for (int i = 0; i < paths.Length; i++)
            {
                Process(paths[i]);
            }
        }
    }
}
