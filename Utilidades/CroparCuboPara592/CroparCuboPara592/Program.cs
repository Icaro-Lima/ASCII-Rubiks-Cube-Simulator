using System;
using System.Drawing;
using System.IO;

namespace CroparCupoPara592
{
    class Program
    {
        static void Process(string path)
        {
            Bitmap original = null;
            using (FileStream stream = new FileStream(path, FileMode.Open))
            {
                original = (Bitmap)Image.FromStream(stream);
            }
            Bitmap newBitmap = new Bitmap(592, 592);

            using (Graphics graphics = Graphics.FromImage(newBitmap))
            {
                graphics.DrawImageUnscaled(original, -original.Width / 2 + newBitmap.Width / 2, -original.Height / 2 + newBitmap.Height / 2);
            }

            File.Delete(path);

            newBitmap.Save(path);
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Digite o caminho: ");
            string path = Console.ReadLine().Replace("\"", "");
            string[] paths = Directory.GetFiles(path, "*.png", SearchOption.AllDirectories);
            Console.WriteLine(paths.Length);
            for (int i = 0; i < paths.Length; i++)
            {
                Process(paths[i]);
            }
        }
    }
}
