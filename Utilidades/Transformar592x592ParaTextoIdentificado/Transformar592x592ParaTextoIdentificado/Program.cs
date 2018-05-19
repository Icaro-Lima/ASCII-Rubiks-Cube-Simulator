using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Drawing;

namespace Transformar592x592ParaTextoIdentificado
{
    class Program
    {
        static byte RoundFor10(byte num)
        {
            if (num == 0)
            {
                throw new Exception("num tem que ser diferente de 0.");
            }

            for (byte i = num; i > num - 4; i--)
            {
                if (i % 10 == 0)
                {
                    return i;
                }
            }

            for (byte i = num; i < num + 4; i++)
            {
                if (i % 10 == 0)
                {
                    return i;
                }
            }

            throw new Exception("Não deu pra aproximar o número a 10.");
        }

        static void Process(string path)
        {
            string imagePath = path;
            string textPath = Path.Combine(Path.GetDirectoryName(path), Path.GetFileNameWithoutExtension(path).Replace("_mask", "") + ".txt");

            Bitmap mask = (Bitmap)Image.FromFile(path);
            List<StringBuilder> lines = new List<StringBuilder>();
            using (StreamReader sr = new StreamReader(textPath))
            {
                string line;
                while ((line = sr.ReadLine()) != null)
                {
                    lines.Add(new StringBuilder(line));
                }
            }

            for (int i = 0; i < lines.Count; i++)
            {
                for (int j = 0; j < lines[i].Length; j++)
                {
                    if (lines[i][j] != ' ')
                    {
                        continue;
                    }

                    Color pixel = mask.GetPixel(j * 8, i * 16);

                    if (pixel.R != 0 && pixel.G == 0 && pixel.B == 0)
                    {
                        int id = RoundFor10(pixel.R) / 10 - 1;
                        lines[i][j] = (char)(id + 65);
                    }
                    else if (pixel.G != 0 && pixel.R == 0 && pixel.B == 0)
                    {
                        int id = RoundFor10(pixel.G) / 10 - 1;
                        lines[i][j] = (char)(id + 77);
                    }
                    else if (pixel.B != 0 && pixel.R == 0 && pixel.G == 0)
                    {
                        int id = RoundFor10(pixel.B) / 10 - 1;
                        lines[i][j] = (char)(id + 97);
                    }
                    else if (pixel.G != 0 && pixel.B != 0 && pixel.R == 0)
                    {
                        int id = RoundFor10((byte)((pixel.G + pixel.B) / 2)) / 10 - 1;
                        lines[i][j] = (char)(id + 109);
                    }
                    else if (pixel.R != 0 && pixel.G != 0 && pixel.B == 0)
                    {
                        int id = RoundFor10((byte)((pixel.R + pixel.G) / 2)) / 10 - 1;
                        lines[i][j] = (char)(id + 48);
                    }
                }
            }

            string[] validForContextLines = new string[lines.Count];
            for (int i = 0; i < lines.Count; i++)
            {
                validForContextLines[i] = lines[i].ToString();
            }

            File.WriteAllLines(textPath, validForContextLines);
        }

        static void Main(string[] args)
        {
            Console.Write("Insira o caminho: ");
            string fullPath = Console.ReadLine().Replace("\"", "");
            string[] paths = Directory.GetFiles(fullPath, "*_mask.png", SearchOption.AllDirectories);
            foreach (string path in paths)
            {
                Process(path);
            }
        }
    }
}
