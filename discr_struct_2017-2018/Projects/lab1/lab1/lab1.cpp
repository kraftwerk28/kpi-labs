
using namespace std;

int main()
{
	return 0;
}

class LinkedList
{
public:
	LinkedList();
	void Push(Element el)
	{

	}

private:

};

class Element
{
public:
	int data;
	Element *parent;
	Element *child;
	Element(int dt, Element *par, Element *child)
	{
		data = dt;
		parent = par;
		child = child;
	}
};
