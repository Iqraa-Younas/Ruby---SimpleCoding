# my_income = 29
# my_taxes = 10
# my_name = "Iqra Younas"
# result = 100/777
# print("hello \t world")
# print(f'I am {result:1.3f}')

import abc


my_list = [1,2,3,4,5]
my_list.append(6)
my_list.sort()
popped_item = my_list.pop(-1)
popped_slice = my_list[::2]


my_dict = {'list1':my_list,'list2':{'a':2,'b':5}}
 
 


# with open('abc.txt',mode='r+') as f:
#     f.write('HAHAHAHA')
#     contents = f.read()
#     print(contents)

d = {'k1':[1,2,{'k2':['This is tricky',{'tough':[1,2,['hello']]}]}]}
print(d['k1'][2]['k2'][1]['tough'][2][0])   
