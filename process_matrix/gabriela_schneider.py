from functools import reduce
from logging import raiseExceptions


#Beggining: looking for the identity matrix that has the size of the original matrix passed by the user ("matrix")
def matrix_identity(numrows, numcols):
    """
    It recieves any matrix and returns the Identity matrix of the original one.
    """
    matrix=[]
    for i in range(numrows):
        row=[]
        for j in range(numcols):
            if i ==j:
                row.append(1)    
            else:
                row.append(0)
        matrix.append(row)
    return matrix

def is_correct_matrix(matrix): #It is to check all elements of matrix are the right type of value!
    """
    Receives: a list of list and check if all elements are integers or floats]
    Returns a boolean value: True if all are integers, false otherwise
    """
    num_rows = len(matrix)  
    num_columns = len(matrix[0])
    for i in range(num_rows):
        for j in range(num_columns):
            if type(matrix[i][j]) != int and type(matrix[i][j]) != float:                
                return False  
    return True



"================================================================================================"
"======================================== First Solution ========================================"
"I took an example and tried to solve it in one step, because"
" it was the better  way I found to understand what I had to do"
"Example: M= matrix and i=row, j=column"
"   [M00, M01, M02, M03]"
"M= [M10, M11, M12, M13]"
"   [M20, M21, M22, M23]"
"   [M30, M31, M32, M33]" 
"   [M40, M41, M42, M43]"
""
"border cases: (3 neighbours, each one)"
"M00---> 1st case"
"M03---> 2nd case"
"M40---> 3rd case"
"M43---> 4th case"

"side cases: (4 neighbours, each one)"
"M01, M02--->5th case"
"M41, M42--->6th case"
"M10, M20, M30, M40---> 7th case"
"M13, M23, M33---> 8th case"

"middle cases: (5 neighbours, each one)"
"M11, M12, M21, M22, M31, M32 ---> 9th case"

"Both solutions works well but I prefer the second one because is an improved version :), that's why I commented solution1"

"================================================================================================"
# def process_matrix_solution1(matrix):
#     """
#     Recieves: a list of lists (matrix)
#     Returns: a matrix with equal lenght and number of elements as the original (the new matrix is a transformation applied to each element of the original matrix)
#     Transformation: each new element (M[i][j]) is the result of calculating the average of itself and 
#     its neighbours (horizontal and verticals ones)  
    
#     """
#     if matrix == []:
#         return []  
#     # Calculate: number of rows as lenght of the matrix(list of lists), and number of columns as the lenght of a row
#     row = len(matrix)
#     column = len(matrix[0])
#     M = matrix_identity(row, column) #Getting the identity matrix that has the size of the original matrix
    
#     for i in range(row):
#         for j in range(column):
#             #border cases 
#             if i == 0 and j == 0: #1st case
#                 M[i][j] = round((matrix[i][j]+matrix[i+1][j]+matrix[i][j+1])/3,2)
#             elif i == 0 and j == column-1: # 2nd case 
#                  M[i][j] = round((matrix[i][j]+matrix[i+1][j]+matrix[i][j-1])/3, 2)          
#             elif i == row-1 and j == 0:  #3rd case
#                 M[i][j] = round((matrix[i][j]+matrix[i-1][j]+matrix[i][j+1])/3, 2)   
#             elif i == row-1 and j == column-1:  #4th case
#                 M[i][j] = round((matrix[i][j]+matrix[i-1][j]+matrix[i][j-1])/3, 2) 
#             #sides cases
#             elif i == 0 and j>=1 and j<=column-2: #5th case
#                 M[i][j]=round((matrix[i][j]+matrix[i+1][j]+matrix[i][j-1]+matrix[i][j+1])/4, 2)
#             elif i == row-1 and j>=1 and j<=column-2: #6th case
#                 M[i][j]=round((matrix[i][j]+matrix[i-1][j]+matrix[i][j-1]+matrix[i][j+1])/4, 2)
#             elif j == 0 and i>=1 and i<=row-2: #7th case
#                 M[i][j]=round((matrix[i][j]+matrix[i-1][j]+matrix[i+1][j]+matrix[i][j+1])/4, 2)
#             elif j == column-1 and i>=1 and i<=row-2: #8th case
#                 M[i][j]=round((matrix[i][j]+matrix[i-1][j]+matrix[i+1][j]+matrix[i][j-1])/4, 2) 

#             #middle cases
#             elif i>=1 and i<=row-2 and j>=1 and j<=column-2: #9th case
#                 M[i][j]=round((matrix[i][j]+matrix[i-1][j]+matrix[i+1][j]+matrix[i][j-1]+matrix[i][j+1])/5, 2)                  
          
#     return M       



"================================================================================================"
"======================================== Second Solution ========================================"
"Once I got  a solution that worked well (solution 1), I tried to improve it to make it easier and simpler to understand."
"That's why I split it up into 2 functions: one to get the neighbours and one to get de average." 

"================================================================================================"

def process_matrix(matrix):
    """
    Recieves: a list of lists (matrix)
    Returns: a matrix with equal lenght and number of elements as the original (the new matrix is a transformation applied to each element of the original matrix)
    Transformation: each new element (M[i][j]) is the result of calculating the average of itself and 
    its neighbours (horizontal and verticals ones) 
    """
    #Analized error's cases: when matrix is an empty list and when there is at least one element of matrix
    #that is not a number (integer or float). It is just in case the user does'nt put a correcta value in the matrix
    if matrix == []:
        return []
    elif not is_correct_matrix(matrix):
        raise ValueError("Wrong type of value. Insert just integers!")


    # Calculate: number of rows as lenght of the matrix(list of lists), and number of columns as the lenght of a row
    num_rows = len(matrix)  
    num_columns = len(matrix[0])
    M = matrix_identity(num_rows, num_columns) #Getting the identity matrix that has the size of the original matrix
    for i in range(num_rows):
        for j in range(num_columns):
            M[i][j] = average(neighbours_values(i,j,matrix, num_rows, num_columns))
    return M
   


def neighbours_values(i, j, matrix, num_rows, num_columns):
    """ 
    Recieves: integers that are the indices i,j and the ranges where they moves.
    From one element of the matrix, I took de neighbours moving by row(i) and by column(j), depending each case specified above . 
    Returns a list with the neighbours of the each element, according to each case.
    """
    
    neighbours =[] #start with an empty list to go saving the neighbours.
    if i == 0 and j == 0:
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j+1])
    elif i == 0 and j == num_columns-1: # 2nd case 
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j-1])        
    elif i == num_rows-1 and j == 0:  #3rd case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i][j+1])     
    elif i == num_rows-1 and j == num_columns-1:  #4th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i][j-1]) 
    #sides cases
    elif i == 0 and j >= 1 and j <= num_columns-2: #5th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j-1])
        neighbours.append(matrix[i][j+1])
    elif i == num_rows-1 and j >= 1 and j <= num_columns-2: #6th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i][j-1])
        neighbours.append(matrix[i][j+1])
    elif j == 0 and i >= 1 and i <= num_rows-2: #7th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j+1])    
    elif j == num_columns-1 and i >= 1 and i <= num_rows-2: #8th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j-1])
    #middle cases
    elif i >= 1 and i <= num_rows-2 and j >= 1 and j <= num_columns-2: #9th case
        neighbours.append(matrix[i][j])
        neighbours.append(matrix[i-1][j])
        neighbours.append(matrix[i+1][j])
        neighbours.append(matrix[i][j-1])
        neighbours.append(matrix[i][j+1])
    
    return neighbours   
    

def average(neighbours):
    """
    Recieves a list
    Returns a float, which is the average of the list. It is rounded to 2 decimals.
    """
    return round(reduce(lambda a,b: (a+b), neighbours,0)/len(neighbours),2) 
    


#testing solution1:
# new_matrix= process_matrix_solution1([[2,4,6,8], [2,4,6,8], [2,4,6,8]])
# print(f"testing of solution1:\n {new_matrix}")
# new_matrix2 = process_matrix_solution1([])
# print(f"testing of solution1:\n {new_matrix2}")


#testing solution2    
new_matrix = process_matrix([[2,4,6,8], [2,4,6,8], [2,4,6,8]])
new_matrix2 = process_matrix([])

print(f"testing of solution2:\n {new_matrix}")
print(f"testing of solution2:\n {new_matrix2}")

#print(is_correct_matrix([[0,"a"], ["b", "c"]]))
