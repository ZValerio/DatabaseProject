package com.CRMThinClient.model.Domain;

public class OffertaAccettata{
	private String codiceOperatore;
	private String codiceCliente;
	private String codiceOfferta;
	private Data dataDiAccettazione;
	
	public OffertaAccettata(String codiceOperatore,String codiceCliente,String codiceOfferta,Data dataDiAccettazione) {
		this.codiceOperatore=codiceOperatore;
		this.codiceCliente=codiceCliente;
		this.codiceOfferta=codiceOfferta;
		this.dataDiAccettazione=dataDiAccettazione;
	}
	
	public String getCodice() {
		return this.codiceOfferta;
	}
	
	public String getOperatore() {
		return this.codiceOperatore;
	}
	
	public String getCliente() {
		return this.codiceCliente;
	}
	
	public Data getDataContratto() {
		return this.dataDiAccettazione;
	}
	
	@Override
	public String toString() {
		return "codice operatore: "+codiceOperatore+"\n"+"codice cliente: "+codiceCliente+"\n"+"codice offerta: "+codiceOfferta+"\n"+"data di accettazione: "+dataDiAccettazione.toString();
	}
}