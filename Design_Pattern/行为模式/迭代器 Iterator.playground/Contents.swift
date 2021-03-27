/*:
 # 迭代器 - Iterator  -- 对象行为型模式
 
 ## 意图
 提供一种方法顺序访问一个聚合对象中各个元素,而又不需暴露该对象的内部表示。
 
 ## 别名
 游标（Cursor)
 
 ## 动机
 一个聚合对象,如列表(ist,应该提供一种方法来让别人可以访问它的元素,而又不需暴露它的内部结构.此外,针对不同的需要,可能要以不同的方式遍历这个列表。但是即使可以预见到所需的那些遍历操作,你可能也不希望列表的接口中充斥着各种不同遍历的操作。有时还可能需要在同一个表列上同时进行多个遍历。
 
 迭代器模式都可帮你解决所有这些问题。这一模式的关键思想是将对列表的访问和遍历从列表对象中分离出来并放入一个迭代器(Iterator)对象中。迭代器类定义了一个访问该列表元素的接口。迭代器对象负责跟踪当前的元素;
 即,它知道哪些元素已经遍历过了。例如,一个列表(List)类可能需要一个列表迭代器( List iterator),它们之间的关系如下图:
 ![](1.png)
 
 考虑到复用性和普遍性，那么更为完善的结构如下
 ![](2.png)
 
 创建迭代器是一个 Factory Method模式(3.3)的例子。我们在这里用它来使得一个客户可向一个列表对象请求合适的迭代器。 Factory Method模式产生两个类层次,一个是列表的个是迭代器的。 Createlterator“联系”这两个类层次。

 ## 适用性
 迭代器模式可用来访问
 * 一个聚合对象的内容而无需暴露它的内部表示。
 * 支持对聚合对象的多种遍历。
 * 为遍历不同的聚合结构提供一个统一的接口(即,支持多态迭代)。

 
 ## 结构
 ![](3.png)
 
 
 ## 参与者
 -- Iterator(迭代器)
 * 迭代器定义访问和遍历元素的接口
 
 -- Concretelterator(具体迭代器)
 * 具体迭代器实现迭代器接口。
 * 对该聚合遍历时跟踪当前位置
 
 -- Aggregate(聚合)
 * 聚合定义创建相应迭代器对象的接口。
 
 -- Concreteaggregate(具体聚合)
 * 具体聚合实现创建相应迭代器的接口,该操作返回 Concreteiteratorf的一个适当的实例。
 
 ## 协作
 Concreteiteratork跟踪聚合中的当前对象,并能够计算出待遍历的后继对象。
 
 ## 效果
 迭代器模式有三个重要的作用:
 1) 它支持以不同的方式遍历一个聚合复杂的聚合可用多种方式进行遍历。例如,代码生成和语义检查要遍历语法分析树。代码生成可以按中序或者按前序来遍历语法分析树。
 迭代器模式使得改变遍历算法变得很容易:仅結用一个不同的迭代器的实例代替原先的实例即可。你也可以自己定义迭代器的子类以支持新的遍历。
 2) 迭代器简化了聚合的接口有了迭代器的遍历接口,聚合本身就不再需要类似的遍历接口了。这样就简化了聚合的接口。
 3) 在同一个聚合上可以有多个遍历每个迭代器保持它自己的遍历状态。因此你可以同时进行多个遍历。
 
 
 ## 实现
 迭代器在实现上有许多变化和选择。下面是一些较重要的实现。实现迭代器模式时常常需要根据所使用的语言提供的控制结构来进行权衡。
 
 1) 谁控制该迭代一个基本的问题是决定由哪一方来控制该迭代,是迭代器还是使用该迭代器的客户。
 当由客户来控制迭代时,该迭代器称为一个**外部迭代器**(external iterator),而当由迭代器控制迭代时,该迭代器称为一个**内部迭代器**(internal iterator)。使用外部迭代器的客户必须主动推进遍历的步伐,
 显式地向迭代器请求下一个元素。相反地,若使用内部迭代器, 客户只需向其提交一个待执行的操作,而迭代器将对聚合中的每一个元素实施该操作。
 外部迭代器比内部迭代器更灵活。例如,若要比较两个集合是否相等,这个功能很容易用外部迭代器实现,而几乎无法用内部迭代器实现。
 
 2) 谁定义遍历算法迭代器不是唯一可定义遍历算法的地方。聚合本身也可以定义遍历算法,并在遍历过程中用迭代器来存储当前送代的状态。我们称这种送代器为一个游标（cursor),因为它仅用来指示当前位置。
 客户会以这个游标为一个参数调用该聚合的Next操作, 而Next操作将改变这个指示器的状态。
 如果迭代器负责遍历算法,那么将易于在相同的聚合上使用不同的迭代算法,同时也易于在不同的聚合上重用相同的算法。从另一方面说,遍历算法可能需要访问聚合的私有变量。如果这样,将遍历算法放入迭代器中会破坏聚合的封装性。
 
 3) 迭代器健壮程度如何在遍历一个聚合的同时更改这个聚合可能是危险的。如果在遍历聚合的时候增加或删除该聚合元素,可能会导致两次访问同一个元素或者遗漏掉某个元素。一个简单的解决办法是拷贝该聚合,并对该拷贝实施遍历,但一般来说这样做代价太高。
 一个健壮的迭代器( robust iterator)保证插人和删除操作不会干扰遍历,且不需拷贝该聚合。有许多方法来实现健壮的迭代器。其中大多数需要向这个聚合注册该迭代器。当插入或删除元素时,
 该聚合要么调整迭代器的内部状态,要么在内部的维护额外的信息以保证正确的遍历。
 
 4) 附加的迭代器操作迭代器的最小接口由 First、Next、 Isdone和Currentitem操作组成其他一些操作可能也很有用。
 
 5) 在C++中使用多态的送代器使用多态迭代器是有代价的。它们要求用一个Factory Method动态的分配迭代器对象。因此仅当必须多态时才使用它们。否则使用在機中分配内存的具体的迭代器。
 多态迭代器有另一个缺点:客户必须负责删除它们。这容易导致错误,因为你容易忘记释放一个使用堆分配的迭代器对象,当一个操作有多个出口时尤其如此。而且其间如果有异常被触发的话,迭代器对象将永远不会被释放。
 Proxy(4.4)模式提供了一个补救方法。
 
 6) 迭代器可有特权访问迭代器可被看为创建它的聚合的一个扩展。迭代器和聚合紧密耦合。在C++中我们可让迭代器作为它的聚合的一个友元(friend)来表示这种紧密的关系。
 
 7) 用于复合对象的选代器在 Composite(4.3)模式中的那些递归聚合结构上,外部送代器可能难以实现,因为在该结构中不同对象处于嵌套聚合的多个不同层次,因此一个外部迭代器为跟踪当前的对象必须存储一条纵贯该 Compositep的路径。有时使用一个内部迭代器会更容易一些。它仅需递归地调用自己即可,这样就隐式地将路径存储在调用機中,而无需显式地维护当前对象位置。
 
 8)空迭代器一个空送代器( Nulliterator)是一个退化的送代器,它有助于处理边界条件。很据定义,一个Nulliterator总是已经完成了遍历:即,它的isdone操作总是返回true。
 
 ## 相关模式
 * Composite(4.3):法代器常被应用到象复合这样的递归结构上。
 * Factory Methode(3.3):多态迭代器靠 Factory Method来例化适当的迭代器子类。
 * Memento(5.6):常与送代器模式一起使用。送代器可使用一个 memento来捕获一个迭代的状态。迭代器在其内部存储 memento。

 
 ## 其他知识点
 
 */


import Cocoa

protocol Iterator {
    init(aggregate: Aggregate)
}

protocol Aggregate {
    func createIterator() -> Iterator
}

struct List: Aggregate {
    func createIterator() -> Iterator {
        return ListIterator(aggregate: self)
    }
}

struct ListIterator: Iterator {
    let aggregate: Aggregate
    init(aggregate: Aggregate) {
        self.aggregate = aggregate
    }
}
