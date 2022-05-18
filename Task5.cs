namespace VDComTest
{
    public static class Observer
    {
        public static int CountCarriages(Train train)
        {
            Carriage currentCarriage = train.Tail;
            int count = 0;
            do
            {
                currentCarriage = currentCarriage.Next;
                count++;
            } while (currentCarriage != train.Tail);

            return count;
        }

        public static void SwitchLights(Train train, Predicate<Carriage> predicate)
        {
            Carriage currentCarriage = train.Tail;
            do
            {
                SwitchLight(currentCarriage, predicate);
                currentCarriage = currentCarriage.Next;
            } while (currentCarriage != train.Tail);
        }

        public static int CountCarriagesAndSwitchLights(Train train, Predicate<Carriage> predicate)
        {
            Carriage currentCarriage = train.Tail;
            int count = 0;
            do
            {
                SwitchLight(currentCarriage, predicate);
                currentCarriage = currentCarriage.Next;
                count++;
            } while (currentCarriage != train.Tail);

            return count;
        }

        private static void SwitchLight(Carriage carriage, Predicate<Carriage> predicate)
        {
            if (predicate(carriage))
                carriage.IsLightOn = true;
            else
                carriage.IsLightOn = false;
        }
    }
    
    public class Train
    {
        public Carriage Tail { get; set; }

        public Train(Carriage tail)
        {
            Tail = tail;
        }

        public void AddFirst(Carriage node)
        {
            Carriage temp = Tail.Next;
            Tail.Next = node;
            Tail.Next.Next = temp;
        }

        public void AddLast(Carriage node)
        {
            Carriage temp = Tail;
            Tail = node;
            Tail.Next = temp.Next;
            temp.Next = Tail;
        }
    } 

    public class Carriage
    {
        public bool IsLightOn { get; set; } = false;
        public Carriage Next { get; set; }

        public Carriage()
        {
            Next = this;
        }

        public Carriage(bool isLightOn)
        {
            IsLightOn = isLightOn;
            Next = this;
        }
    }
}
