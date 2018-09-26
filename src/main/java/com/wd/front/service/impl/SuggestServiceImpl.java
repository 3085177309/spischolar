package com.wd.front.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.search.suggest.Suggest.Suggestion.Entry;
import org.elasticsearch.search.suggest.Suggest.Suggestion.Entry.Option;
import org.elasticsearch.search.suggest.SuggestBuilder;
import org.elasticsearch.search.suggest.SuggestBuilders;
import org.springframework.stereotype.Service;

import com.wd.comm.Comm;
import com.wd.front.service.SuggestServiceI;
import com.wd.util.ClientUtil;

@Service
public class SuggestServiceImpl implements SuggestServiceI {

	@Override
	public List<String> getSuggest(String value) {
		return getSuggest(value,10);
	}

	@Override
	public List<String> getSuggest(String value, int size) {
		assert size>0;
		Client client = ClientUtil.getClient();
		SuggestBuilder suggestionsBuilder = new  SuggestBuilder();
		suggestionsBuilder.addSuggestion("complete", SuggestBuilders.completionSuggestion("suggest").text(value).size(size));
//		suggestionsBuilder.text(value); 
//		suggestionsBuilder.field("suggest");
//		suggestionsBuilder.size(size);
		SearchResponse resp  = client.prepareSearch(Comm.DEFAULT_INDEX).suggest(suggestionsBuilder).execute().actionGet();
		List<String> result = new ArrayList<String>();
		List<? extends Entry<? extends Option>>  entries = resp.getSuggest().getSuggestion("complete").getEntries();
		for (Entry<? extends Option> e : entries) { 
			Iterator<? extends Option> ite  = e.getOptions().iterator();
			while(ite.hasNext()){
				Option o = ite.next();
				result.add(o.getText().toString());
			}
		}
		return result;
	}

}
