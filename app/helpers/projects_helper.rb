module ProjectsHelper

def sort_by_sorting_order(x,y)
  if( x.sorting_order == nil )
    x.sorting_order = 0
  end
  if( y.sorting_order == nil )
    y.sorting_order = 0
  end
  
  x.sorting_order <=> y.sorting_order
end

end
