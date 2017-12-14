#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <time.h>

void msort(int arr[], int length);
void print_array(int arr[], int length);

int main(int argc, char **argv)
{
  int arr[argc - 1];
  int i = 0;
  clock_t start, end;
  for (char **c = argv + 1; c < argv + argc; c++, i++)
    arr[i] = atoi(*c); 

  printf("originally: ");
  print_array(arr, argc - 1);

  start = clock();
  msort(arr, argc - 1);
  end = clock();

  printf("now: ");
  print_array(arr, argc - 1);
  printf("time elapsed: %f seconds\n", (double) (end - start) / CLOCKS_PER_SEC); 
  return 0; 
}

/* merge: merges two arrays [start...mid] and [mid+1...end] in order */
void merge(int *arr, int *left, int llen, int *right, int rlen)
{
  int i = 0, j = 0, k = 0;

  while (i < llen && j < rlen)
    if (left[i] < right[j])
      arr[k++] = left[i++];
    else
      arr[k++] = right[j++];

  while (i < llen)          /* merge the remaining elements */
    arr[k++] = left[i++];
  while (j < rlen)
    arr[k++] = right[j++]; 
}

/* msort: sorts an array of length n with efficiency O(nlogn) */
void msort(int *arr, int len) {
  if (len <= 1)
      return;

    int m = len / 2; /* midpoint */

    int *copy = (int *) malloc(sizeof(int) * len);
    for (int *i = arr, *c = copy; i < arr + len; i++, c++)  /* copy the original array */
      *c = *i;
    
    int *left = copy;
    int *right = copy + m;
    
    msort(left, m);
    msort(right, len - m); 
    merge(arr, left, m, right, len - m);
  }

void print_array(int arr[], int len)
{
  printf("[ %i", *arr++); 
  for (int *c = arr, width = 3; c < arr + len - 1; c++, width += 4) {
    printf(", %i ", *c);
    if (width > 80) {          /* approximate wrap for terminal */
      printf("\n");
      width = 0;
    }
  }
  printf("]\n");
}

