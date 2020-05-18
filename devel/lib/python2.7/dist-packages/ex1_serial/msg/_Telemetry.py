# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from ex1_serial/Telemetry.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class Telemetry(genpy.Message):
  _md5sum = "223bde042d75b50cc1fe2380be06acc7"
  _type = "ex1_serial/Telemetry"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """# Custom data type for telemetry messages. 
uint16 id
uint8 cmd
uint8 len 
float32 opt 
"""
  __slots__ = ['id','cmd','len','opt']
  _slot_types = ['uint16','uint8','uint8','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       id,cmd,len,opt

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(Telemetry, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.id is None:
        self.id = 0
      if self.cmd is None:
        self.cmd = 0
      if self.len is None:
        self.len = 0
      if self.opt is None:
        self.opt = 0.
    else:
      self.id = 0
      self.cmd = 0
      self.len = 0
      self.opt = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_H2Bf().pack(_x.id, _x.cmd, _x.len, _x.opt))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      end = 0
      _x = self
      start = end
      end += 8
      (_x.id, _x.cmd, _x.len, _x.opt,) = _get_struct_H2Bf().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_H2Bf().pack(_x.id, _x.cmd, _x.len, _x.opt))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      end = 0
      _x = self
      start = end
      end += 8
      (_x.id, _x.cmd, _x.len, _x.opt,) = _get_struct_H2Bf().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_H2Bf = None
def _get_struct_H2Bf():
    global _struct_H2Bf
    if _struct_H2Bf is None:
        _struct_H2Bf = struct.Struct("<H2Bf")
    return _struct_H2Bf