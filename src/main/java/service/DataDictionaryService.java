package service;

import pojo.DataDictionary;

import java.util.List;

public interface DataDictionaryService {

    List<DataDictionary> queryExpense(DataDictionary dataDictionary);
}
