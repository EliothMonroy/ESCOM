interface Test
{
    public void wish();e
class Main
{
    public static void main(String[] args)
    {
        Test t=new Test()
        {
            public void wish()
            {
                System.out.println("output: hello how r u");
            }
        };
    t.wish();
    }
}
