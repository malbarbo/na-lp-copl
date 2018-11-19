class ProducerConsumer {
    public static void main(String[] args) {
        Queue q = new Queue(10);
        Thread p1 = new Producer("p1", q);
        Thread p2 = new Producer("p2", q);
        Thread c1 = new Consumer("c1", q);
        Thread c2 = new Consumer("c2", q);
        p1.start();
        p2.start();
        c1.start();
        c2.start();
    }
}

class Queue {
    private int[] que;
    private int nextIn, nextOut, filled, queSize;

    public Queue(int size) {
        que = new int[size];
        filled = 0;
        nextIn = 0;
        nextOut = 0;
        queSize = size;
    }

    public synchronized void deposit(int item) {
        while (filled == queSize) {
            try {
                System.out.println("esperando: o buffer está cheio");
                wait();
            } catch (InterruptedException e) {
            }
        }
        que[nextIn] = item;
        nextIn = (nextIn + 1) % queSize;
        filled++;
        notifyAll();
    }

    public synchronized int fetch() {
        int item;
        while (filled == 0) {
            try {
                System.out.println("Esperando: o buffer está vazio");
                wait();
            } catch (InterruptedException e) {
            }
        }
        item = que[nextOut];
        nextOut = (nextOut + 1) % queSize;
        filled--;
        notifyAll();
        return item;
    }
}

class Producer extends Thread {
    private Queue buffer;
    String id;

    public Producer(String id, Queue que) {
        buffer = que;
        this.id = id;
    }

    public void run() {
        int newItem = 0;
        while (true) {
            newItem++;
            System.out.println(id + "   " + newItem);
            try {
                Thread.sleep((long) (Math.random() * 100));
            } catch (InterruptedException e) {
            }
            buffer.deposit(newItem);
        }
    }
}

class Consumer extends Thread {
    private Queue buffer;
    String id;

    public Consumer(String id, Queue que) {
        buffer = que;
        this.id = id;
    }

    public void run() {
        int storedItem;
        while (true) {
            storedItem = buffer.fetch();
            try {
                Thread.sleep((long) (Math.random() * 100));
            } catch (InterruptedException e) {
            }
            System.out.println(id + "    " + storedItem);
        }
    }
}
