###
  Copyright (c) 2010 Maxim Vasiliev, Rowan Crawford
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
 
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 
  @author Maxim Vasiliev
  Date: 09.09.2010
  Time: 19:02:33

  @author Rowan Crawford
  Date: 11.05.2011

  Returns form values represented as Javascript object
 "name" attribute defines structure of resulting object

  Based on form2object (nee form2js): http://code.google.com/p/form2js/ 
###

$.fn.extend
  toObject: (delimiter = '.', ignoreEmpty = true)->
    fields = $(this).serializeArray()
    result = {}
    arrays = {}
    for field in fields
      value = field.value
      continue if value == '' && ignoreEmpty
      name = field.name
      nameParts = name.split(delimiter)
      currResult = result
      len = nameParts.length
      for namePart, j in nameParts
        if namePart.indexOf('[]') > -1 && j == len - 1
          arrName = namePart.substr(0, namePart.indexOf('['))
          currResult[arrName] = [] unless currResult[arrName]
          currResult[arrName].push(value)
        else
          if namePart.indexOf('[') > -1
            arrName = namePart.substr(0, namePart.indexOf('['))
            arrIdx = namePart.replace(/^[a-z]+\[|\]$/gi, '')
            ###
             * Because arrIdx in field name can be not zero-based and step can be
             * other than 1, we can't use them in target array directly.
             * Instead we're making a hash where key is arrIdx and value is a reference to
             * added array element
            ###
            arrays[arrName] = {} unless arrays[arrName]
            currResult[arrName] = {} unless currResult[arrName]
            if j == len - 1
              currResult[arrName].push(value)
            else
              unless arrays[arrName][arrIdx]
                currResult[arrName].push({})
                arrays[arrName][arrIdx] = currResult[arrName][currResult[arrName].length - 1]
            currResult = arrays[arrName][arrIdx]
          else
            if j < len - 1
              currResult[namePart] = {} unless currResult[namePart]
              currResult = currResult[namePart]
            else
              currResult[namePart] = value
    result    
            