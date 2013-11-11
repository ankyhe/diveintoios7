#! /usr/bin/python
import lldb

def __lldb_init_module(debugger, internal_dict):
  debugger.HandleCommand('type summary add MyAddress --python-function my_summary_defines.MyAddress_Summary')

def MyAddress_Summary(value, internal_dict):
  name = value.GetChildMemberWithName('_name')
  return name.GetSummary()

