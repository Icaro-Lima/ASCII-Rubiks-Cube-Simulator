using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GerarLadosIdentificadores
{
    class Program
    {
        static void GerarLados(int quantidade, string prefix, Color corInicial, Color incremento)
        {
            for (int t = 0; t < quantidade; t++)
            {
                Bitmap bitmap = Properties.Resources.white.Clone(new Rectangle(0, 0, Properties.Resources.white.Width, Properties.Resources.white.Height), Properties.Resources.white.PixelFormat);
                for (int i  = 0; i < bitmap.Height; i++)
                {
                    for (int j = 0; j < bitmap.Width; j++)
                    {
                        Color actualPixel = bitmap.GetPixel(j, i);
                        if (actualPixel.R == 255 && actualPixel.G == 255 && actualPixel.B == 255)
                        {
                            bitmap.SetPixel(j, i, corInicial);
                        }
                    }
                }

                corInicial = Color.FromArgb(corInicial.A, corInicial.R + incremento.R, corInicial.G + incremento.G, corInicial.B + incremento.B);

                bitmap.Save(prefix + t + ".png");
            }
        }

        static void Main(string[] args)
        {
            GerarLados(9, "L", Color.FromArgb(10, 10, 0), Color.FromArgb(10, 10, 0));
            GerarLados(9, "R", Color.FromArgb(0, 10, 10), Color.FromArgb(0, 10, 10));
        }
    }
}
