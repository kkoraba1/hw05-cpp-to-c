#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Vehicle Vehicle;

struct Vehicle
{
  void (*accelerate)(Vehicle *);
  void (*brake)(Vehicle *);
};

typedef struct
{
  Vehicle base;
  char *owner;
} Car;

void startEngine(Vehicle *v)
{
  (void)v;
  puts("Engine started!");
}

void accelerate(Vehicle *v)
{
  if (v && v->accelerate)
    v->accelerate(v);
}

void brake(Vehicle *v)
{
  if (v && v->brake)
    v->brake(v);
}

static void carAccel(Vehicle *v)
{
  (void)v;
  puts("Car: Pressing gas pedal...");
}

static void carBrake(Vehicle *v)
{
  (void)v;
  puts("Car: Applying brakes...");
}

Vehicle *newCar(const char *owner)
{
  Car *c = malloc(sizeof(Car));
  if (!c)
    return NULL;
  c->base.accelerate = carAccel;
  c->base.brake = carBrake;
  if (owner)
    {
      c->owner = malloc(strlen(owner) + 1);
      if (c->owner)
        strcpy(c->owner, owner);
    }
  else
    {
      c->owner = NULL;
    }
  return (Vehicle *)c;
}

void remVech(Vehicle *v)
{
  if (!v)
    return;
  Car *c = (Car *)v;
  free(c->owner);
  free(c);
}

int main(void)
{
  Vehicle *myCar = newCar(NULL);
  if (!myCar)
    return 1;
  startEngine(myCar);
  accelerate(myCar);
  brake(myCar);
  remVech(myCar);
  return 0;
}
