// Generated by gencpp from file ex1_serial/Read.msg
// DO NOT EDIT!


#ifndef EX1_SERIAL_MESSAGE_READ_H
#define EX1_SERIAL_MESSAGE_READ_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace ex1_serial
{
template <class ContainerAllocator>
struct Read_
{
  typedef Read_<ContainerAllocator> Type;

  Read_()
    : data(0)  {
    }
  Read_(const ContainerAllocator& _alloc)
    : data(0)  {
  (void)_alloc;
    }



   typedef uint8_t _data_type;
  _data_type data;





  typedef boost::shared_ptr< ::ex1_serial::Read_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::ex1_serial::Read_<ContainerAllocator> const> ConstPtr;

}; // struct Read_

typedef ::ex1_serial::Read_<std::allocator<void> > Read;

typedef boost::shared_ptr< ::ex1_serial::Read > ReadPtr;
typedef boost::shared_ptr< ::ex1_serial::Read const> ReadConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::ex1_serial::Read_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::ex1_serial::Read_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace ex1_serial

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/melodic/share/std_msgs/cmake/../msg'], 'ex1_serial': ['/home/rovertx2/HERO_EX1/src/ex1_serial/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::ex1_serial::Read_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::ex1_serial::Read_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ex1_serial::Read_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ex1_serial::Read_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ex1_serial::Read_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ex1_serial::Read_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::ex1_serial::Read_<ContainerAllocator> >
{
  static const char* value()
  {
    return "7c8164229e7d2c17eb95e9231617fdee";
  }

  static const char* value(const ::ex1_serial::Read_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x7c8164229e7d2c17ULL;
  static const uint64_t static_value2 = 0xeb95e9231617fdeeULL;
};

template<class ContainerAllocator>
struct DataType< ::ex1_serial::Read_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ex1_serial/Read";
  }

  static const char* value(const ::ex1_serial::Read_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::ex1_serial::Read_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Custom data type for streamed telemetry bytes \n"
"uint8 data\n"
;
  }

  static const char* value(const ::ex1_serial::Read_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::ex1_serial::Read_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.data);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Read_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::ex1_serial::Read_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::ex1_serial::Read_<ContainerAllocator>& v)
  {
    s << indent << "data: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.data);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EX1_SERIAL_MESSAGE_READ_H