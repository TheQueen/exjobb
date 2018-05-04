//input: int pid
//output: 0 if success, -1 if no input
#include <stdio.h>
#include <stdlib.h>
#include <papi.h>
#include <string.h>
#define MIN_NR_OF_INPUTS 1 //byt till 2? ^^
#define MAX_NR_OF_PARTITIONS 8
#define INITIAL_SIZE_OF_PART_1 2

int nrOfPartitions = 0;
int currentSizeOfPart1;


int controller(const char * pidChar);
void addPartition(int pid);
int measureDTLBmissesPAPI(int argv);

int main(int argc, const char * argv[])
{
  if (argc <= MIN_NR_OF_INPUTS)
  {
    printf("NOT ABLE TO USE CONTROLLER WITHOUT INPUT\n");
    return -1;
  }
  controller(argv[1]);
  return 0;
}

int controller(const char * pidChar)
{
  int pid = atoi(pidChar);
  int returnValue = -1;
  char command[50] = "sudo ./initPallocTest.sh ";

  strcat(command, pidChar);
  system(command);

  //addPartition(pid);

  //nrOfPartitions = 1;
  //currentSizeOfPart1 = INITIAL_SIZE_OF_PART_1;

  while(kill(pid, 0) == 0)
  {

    returnValue =  measureDTLBmissesPAPI(pid);
    printf("Return from DTL: %d\n", returnValue);
    //repartition according to some PAPI-value
  }
  printf("Controller not done yet...\n");
  return 0;
}

void addPartition(int pid)
{
  char command[50] = "";
  sprintf(command, "sudo ./addPartition.sh %d, %d", pid, nrOfPartitions+1); //ska det verkligen vara ett komma mellan inputsen? ^^
  system(command);
  nrOfPartitions++;
}

//not a good function
void repartition(int diff)
{
  char command[50] = "";
  sprintf(command, "sudo echo 0-%d > /sys/fs/cgroup/palloc/part$2/palloc.bins", currentSizeOfPart1+diff);
  currentSizeOfPart1+=diff;
  system(command);
}

///////////////////SKA BORT TILL ANNAN FIL///////////////// --------------------------STINAS

int getVideoStats(int pid)
{
  int secondsTheVideoBeenOn, videoPosition;
  char command[50] = "ps -o etimes= -p ";
  File * fp;

  sprintf(command, "%d", pid); 
  secondsVideoBeenOn = system(command);

  fp = fopen("FPStest.txt", "r");
  fscanf(fp, "%d", );
}


int measureDTLBmissesPAPI(int pid)
{
  int retval, eventSet = PAPI_NULL;
  long_long value[1];
  value[0] = 0;

  /********************init library************************/

  retval = PAPI_library_init(PAPI_VER_CURRENT);

  if(retval != PAPI_VER_CURRENT && retval > 0) //error = DEADBEEF
    printf("PAPI-error, libary mismatch\n");

  if(retval < 0)
		printf("PAPI-error, init error\n");

  /*******************event setup**************************/

  if((retval = PAPI_create_eventset(&eventSet)) != PAPI_OK)
    printf("PAPI-error, setup create eventset: %s\n", PAPI_strerror(retval));

  if((retval = PAPI_add_event(eventSet, PAPI_TLB_DM)) != PAPI_OK)
    printf("PAPI-error, setup add event: %d\n", retval);

  if((retval = PAPI_attach(eventSet, pid)) != PAPI_OK)
    printf("PAPI-error, setup attach: %d\n", retval);

  /******************run event*****************************/

  if((retval = PAPI_start(eventSet)) != PAPI_OK)
    printf("PAPI-error, run event start: %d\n", retval);

  if((retval = PAPI_reset(eventSet)) != PAPI_OK)
    printf("PAPI-error, run event reset: %d\n", retval);

    usleep(1000000);

  if((retval = PAPI_stop(eventSet, value)) != PAPI_OK)
    printf("PAPI-error, run event stop: %d\n", retval);

  if((retval = PAPI_read(eventSet, value)) != PAPI_OK)
    printf("PAPI-error, run event read: %d\n", retval);
    printf("VALUE: %lld\n", value[0]);
  /*****************cleanup cleanup**********************/

  if((retval = PAPI_cleanup_eventset(eventSet)) != PAPI_OK)
    printf("PAPI-error, cleanup: %d\n", retval);

  return value[0];
}
