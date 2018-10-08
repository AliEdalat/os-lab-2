#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

void bubble_sort(int* arr, int* indices, int n)
{
    int i, j;
    for (i = 0; i < n-1; i++)
    {
        for (j = 0; j < n-i-1; j++)
        {
            if (arr[j] > arr[j+1])
            {
                swap(&arr[j], &arr[j+1]);
                indices[j] = j+1;
            }
        }
    }
}

void write_to_file(int* argv, int* indices, int argc)
{
    int fd, i;

    fd = open("result.txt", O_CREATE | O_WRONLY); //TODO: check file name from the project description

    if (fd < 0)
    {
        printf(1, "sort: result.txt could not be opened.");
        exit();
    }

    for (i = 0; i < argc - 1; ++i)
    {
        write(fd, argv[indices[i]], strlen(argv));
    }
    write(fd, "\n", 1);
}

int
main(int argc, char* argv[])
{
    int i;
    int nums[argc - 1];
    int indices[argc - 1];

    if(argc <= 1){
        printf(1, "sort: no arguments passed.");
        exit();
    }

    for(i = 1; i < argc; i++) {
        nums[i - 1] = atoi(argv[i]);
        indices[i - 1] = i - 1;
    }

    bubble_sort(nums, indices, argc - 1);

    for (i = 0; i < argc; ++i)
    {
        printf(1, "%s ", argv[indices[i]]);
    }
    printf(1, "\n");

//    write_to_file(argv, indices, argc);
    exit();
}
