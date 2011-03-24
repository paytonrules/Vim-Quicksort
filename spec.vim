function! Swap(first, second)
  let temp = s:sortingList[a:first]
  let s:sortingList[a:first] = s:sortingList[a:second]
  let s:sortingList[a:second] = temp
endfunction

function! Split(first, last)
  let x = s:sortingList[a:first]
  let splitPoint = a:first
  
  for unknown in range(a:first + 1, a:last)
    if s:sortingList[unknown] < x
      let splitPoint += 1
      call Swap(unknown, splitPoint)
    end
  endfor

  call Swap(a:first, splitPoint)
  return l:splitPoint
endfunction

function! s:SortGlobalList(first, last)
  if a:first < a:last
    let splitPoint = Split(a:first, a:last)
    call s:SortGlobalList(a:first, splitPoint - 1)
    call s:SortGlobalList(splitPoint + 1, a:last)
  endif
endfunction
 
function! QuickSort(theList)
  let s:sortingList = a:theList
  if len(s:sortingList) > 1
    let maxIndex = len(s:sortingList) - 1
    call s:SortGlobalList(0, maxIndex)
  endif
  return s:sortingList
endfunction

SpecBegin 'title' : 'quicksort'

It should sort an empty list.
Should be equal QuickSort([]), []

It should sort a list with one item.
Should be equal QuickSort([1]), [1]

It should sort a list with two items, already sorted.
Should be equal QuickSort([1, 2]), [1, 2]

It should sort a list with two items, unsorted
Should be equal QuickSort([2, 1]), [1, 2]

It should sort a list with three items, unsorted
Should be equal QuickSort([2, 4, 1]), [1, 2, 4]

It should sort pi
Should be equal QuickSort([3, 1, 4, 1, 5, 9, 2, 7]), [1, 1, 2, 3, 4, 5, 7, 9]
