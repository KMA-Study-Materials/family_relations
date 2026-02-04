import itertools

females = {"jane", "anna", "mary", "catlyn", "sarah"}
males = {"john", "jim", "peter", "alex", "tom", "micky"}

# parent(Parent, Child)
parent_relations = {
    ("john", "jim"), ("jane", "jim"), ("jim", "anna"),
    ("jim", "tom"), ("anna", "peter"), ("tom", "mary"), ("tom", "alex")
}


def get_person(x): # Union
    return x in females or x in males

def get_fathers(): # Intersection
    return {(p, c) for p, c in parent_relations if p in males}

def get_mothers():
    return {(p, c) for p, c in parent_relations if p in females}

def get_women_by_diff(): # Difference
    all_people = females | males
    return all_people - males

def is_parent(x): # Projection
    return any(p == x for p, c in parent_relations)

def possible_pairs(): # Cartesian Product
    return list(itertools.product(males, females))

def grandfather_of_peter(): # Theta-Join & Selection
    fathers = get_fathers()
    return {f for f, child in fathers if (child, "peter") in parent_relations}



def get_children(p_name): # Inverse
    return {c for p, c in parent_relations if p == p_name}

def get_parents(c_name):
    return {p for p, c in parent_relations if c == c_name}

def get_siblings(x): # Inequality: X \= Y
    siblings = set()
    for p in get_parents(x):
        for child in get_children(p):
            if child != x:
                siblings.add(child)
    return siblings



def get_ancestors(person): # Transitive Closure
    ancestors = set()
    parents = get_parents(person)
    for p in parents:
        ancestors.add(p)
        ancestors.update(get_ancestors(p))
    return ancestors

def are_blood_relatives(x, y): # Symmetric Closure
    if x == y: 
        return False
    return bool(get_ancestors(x) & get_ancestors(y))

def in_genetic_clan(x, y): # Reflexive Closure
    return x == y or are_blood_relatives(x, y)


if __name__ == "__main__":
    print(f"Fathers (Intersection): {get_fathers()}")
    print(f"Women (Difference): {get_women_by_diff()}")
    print(f"Grandfathers of Peter (Join): {grandfather_of_peter()}")
    print(f"Ancestors of Mary: {get_ancestors('mary')}")
    print(f"Is Jim in Jim's genetic clan? {in_genetic_clan('jim', 'jim')}")