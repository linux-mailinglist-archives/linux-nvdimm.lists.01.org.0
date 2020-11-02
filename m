Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58092A3284
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Nov 2020 19:06:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3550162FF498;
	Mon,  2 Nov 2020 10:06:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.163.184.147; helo=sonic309-21.consmr.mail.ne1.yahoo.com; envelope-from=jones_desmond.j568@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7055C162FF497
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604340362; bh=qYgR5pn3mpwhtvVFebgfRrJOEFYsieVyZ0yx33TZy5c=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mc7BHp8DxXB2ciqbrLYGZrlvr5sF1zUYoP+Ra365EJTYdIWe5XO/fe4ovSKOvl5hgCw9sfFmUwLfWdJx3ZIqLBhRv+u4LSH3yOMMPVNcMTAIzzkRedx9+uLHZzMIWJZXYldQXQDZP24n2BvoiCKbShR2IimM0onXEKmXxfzODmA2YURFVvPk7jiloRJgAmQVOElif0I5WZNP4yq6Zo/c/AE/7aq5WFSMIEILcWEph6+8+U+C6v8pOrgBghe5U+84MyNHSr2C/5f9AHx9Og/c8S2D70d1Bthkfksv53RLLdE/xFye8H1l21cBLplORBk0kpyV/YXzpFJ7K5439VcN5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604340362; bh=b8xVutsvSWuiUZOLkQoJdP6+sxDOYuQSIHfZDRWI5ur=; h=Date:From:Subject; b=IwmHTO0Jo1LeT7H6DzEFjvnQkquqNay0/C+CBuR/xWskPgW71Z4U5YSYrBcpmss4Avz867ITCq66dgR+9gXv2+j35PTkU070l5Ex3nTdy+rA9X9eCJ+7SIf51mDlAwXZbNeJrFxZR0A+d/ci3a4ChoR33yKXM9+jpcG+sMFPSEb9THW94ooybQ4xfrCYEG57mOU+adne1im4aPuJtWrgGdmfsmxHhTUVPW/ZP1cTQaPNsiEMAyPwqdZyLf7WAFz241qoYBDgiXSQN6C+bQ5gU9bie6T4xHxNW39QG9Q1TP7e4w48iHa+V/QtZzPYlQu8E2Ms9kFqLtpADkOATBiyYg==
X-YMail-OSG: _A.W4CUVM1lTsRLVpthKeFoczIP5Ebm0TeXdj1qHCYKMJQHZTTazWuJVIqC_TSb
 6.y2ZN6V.F9RJTLLgDSixKkiH1YIiUfZh0nVDKpPf85zylV.c15INlyT1I_7uZBHj7AAzHf2EB2N
 BaDzdol8O013pn5SRKrHM3Nz1JfCY8VCyYdlq7AVA0bR6zMqO86nRx9Z2gjC6kaRYrwqVm8VZ8VN
 TOnJaNindy_Z6UsM.VqS6g0Txdlw4oT7mK0_D9XrPtrUts5rjX.nptW4CTxBiTyOup4JYshgpMc2
 M6X04WVTi3z9pHKf1WOYimi7Y_ZqH511hTwcFEaJthq31dEmrNCWhMpZYg5EDUIMPemChvvxVpt6
 a27H1x1PvS1phRbLLDBNza6_g7JyKWUtzbdlVUSQPuYpwg4muHxgqnPWKs4oL_fF00wJokPl53M0
 kVBmuNHrRKZlFGu3tXPRCdkXE.Odv3CO862h1HLZf8oh9zPgiKx3XqSFYOHuRUphQVS_.IszHhr2
 XqZX3h31qrIAFA5yGoSGjV6bJuYMYNV_I35tMqMexV7Vk2pLVc5.kyJFhW23SBea9JRxIewZn0Yv
 9OYXGBSpTOjLwoUaQZ6yygv0qbKypUKslua4ppyytJalwAQeIwctEJ_TLRHjDIBZWLWjvHSkcMYW
 PcdvLeozNHgV1jdMFuAaMbmd_Io.bib24lzKBYFlRy4OUy0JH1vQ9rWGlxsfc4rpc3RnH4psml2.
 mHU_iprjhXj8SpfgVrDrg9QNo1MiCIKumG23AMoBRMJxdoih3d_qllpztOSp8JHQFCOXYkCVPaRs
 Ub1mV4DaZepD2ofkOSDuF97oV4XLX4YIm2xcIQsAD5RBiX1H6X4ym8EQKu4orAr9ydFhf63NVkYU
 bc1plOcnNXO0GZVE4_dCJVPAj9N62B8ylnUMGe190yuM8o4bToj3QijONhqQ7TsD1YxHMOuKs5iS
 Zms7GgawjWok8uLaL1LoLHknnFzPVYJC..f7laovNzfcpbOcFB8m539qYit8i8prBgdtegpR5Qef
 2YGoZnq4nTzwKGzOy7aj4F_T9sWP5lmn.qtpz7GcYpAMukoaZdYWVkYt8Ye9YQZTYYVueqvuiT4_
 qKk7QevY6NDfPYUbuJqmxkurx_YsMVXXxyDz9txEyFjN7fGC2NhKx2OgLLVYCeX9X6kM9ajE373p
 k.l2D.iFRJGlB7b1mKlW3Wm.xwdBy2AIBT2Ox3s6pBd2ljiTw3Txs9gnhr9yO3Uopzxbjd0RqBOA
 GOgUIHenqdg8TvcADCOWur.eJI_FxloobiOncSINSqGne.WS1WJyp5EPFv9PGyYI8RnAwAXPQ70L
 z0cb9pAvRNf.A3CKxlg7MYE6.8kfp3Ies0xUCwujyEsCNx6C1XX_S7KflG8f1Luhe_oQDa_P6IKX
 goPO7ILJL6pD6exK_nmgJzJJdOsZvxtpR5ELEMS23zWRvbGXmGxJbsjEi2BJNfZ1WDSpi7azkNXL
 pSIubNm_YxR2px910DuuCdXyZ.0MsfqytE7y1ZgSiN0s89SJD4oThnglq1.K6vJk6f5GXLJDDdT.
 FwvZ7Gz1G2S0hclUHmfx0oyZoMeSb1LKHPTQdSp6CDOGud5lKj7_9E4p2flqMfiIe9_HnvMeutHI
 il2sl_QLMiZOhkHl2y7Us4ms9xoGQ78h6gkpL7oxp3bWa76DXOzsSeITz1DA3Wq53buOLh_Xom3u
 q4V_1l9Ro4b6raWv._JR_9AcItbDDusq3xR0wjO5LoWJ8uNao8UIJS55GlGnjOgcKHBlpGQuI_mx
 An25DYOgTUCw4d5Wvuny3wPDaOzxK4efTXIxkrIkXBp3usyCNYvD4BrmmuTqMv7BxSk1TynLO.BX
 mRlKspHZAdpw4oP1dn3RaK2YjC2EFGEak9f09J_Sk0C5dMX3u5W_kj_T7M3A1kiUjpNUIs3UPB9E
 HadQdmsKyQxhvS3KTQG5LafAvy8g9W9D6lD4SO9RU2Et16PybuU0_JucVVFsNyuylL3LwONPYsYp
 VOTFINoSrt6SVd66p7B1.c1ZffxrqkDLLyHrIoH.2apJa8nDjmTwIJVr3gTeKb25Z1bqykMRIk.z
 28XPCG_m0pOtB.3rI0D09XHKY9qgns4KR1CiH8SzIjJP2g9xdKFf58BIc8_YFXFxFa.vLdhM84bo
 GU4pNn92A2OO8aqP0ibxsq4ryFupdKJ1Nkf6j5Dvtgf5GU5xtBPPNskA5wRffZEw5ZEumfWUuNjS
 a0GeJMJbYdRYufwHmeKOLwhb6EBmotHAz9x4VWAk6Fqyb3ZAIQdBODhWtDgSBRK83Y0nIeDSYDn1
 HEqhkJhUzCIyVtHTq1lWbDoSxzpcJ00ME7BLBlkQVqpxYTGg2OzVlF1xUptMx4UX2s0.KO7eWRqQ
 zqhrf1Fp3cyWjJiddhZApVTHw4kzsvaG3KcAECpF4gOYOz5GYYdlT2SO63X8hnWYj1yZBpX1s2EN
 9An749eDUVT2f4CnZ5y_tva5ma0D2Pn4p.32at7j4wr37oFGPRSx4Vaj1ejomxKPXzhck5v91YDP
 RDD41HrDo6XIn8N7XmPXO4MXzi8XFvWh7T7f6RSGlth.a_tH.4pSb6VlJPOMmGHkrqA7_5isTmPH
 YhfGkSYPrD3LNu7EeWU6yoCZUQklztX9he6aFMZTTajzf1u260iDe7J5J2McsSIojrXal8OjM5Cm
 g.U2C0yf5z5nSrbMZL6vZs1uWNuM7g6M_yLUMXKz1Q5TFy206QYKBeVww9a4XHpc7Mtlm4.QJhZp
 exQF4gzeVTxwtkTYp7in01Y_Mhnp5zmz1GaK1lOFh5zZoCmGVg4ErcrgT3Xb8EEkrkik9IVQBBdE
 GgOulLqWTs3BcOgySK21S7xXzZP6woGBtR8aulRKkpEQItx0T6msEDhW9BkxsnYnwteir_WRZ.cD
 AIfSENZGuWSADJbnXxu0N8rxgqwO4bRHP62IKStpeqkXUCowrjg7aY_GsQmKRxGv4W4_nJvgKMAv
 qEh9ucRsI664YPG8hXKlLbb1K.ox4DZbcWAH_bNA2VaE6R7o6iabF2XkrIlmSXxsgCvaBnO63AgZ
 urtkJL0UxNYyuAxr21P.EZPNmVSePQHQU2YM07wO_WWJUizDlHZyJqi.DKPmF9kloPIAAXHcDSot
 dtNo17rLdGg.N5Nl0dWzz_qVpaDHOvB_egejYL6HP7W.hfsAWfH4Q3YLcSvMur9e0eGVntpgJUO_
 1I9se6khgT0uZJCGC0Jauh7YjTvL1NDBD0_BWUk.xoAwf5U5pkIt0VL12_BP6RXj7n29DWNvkowD
 vJk2ZmFagxWW5mF6eSPrmFE6Yb4RIKM8DdhMOALey4aYqZiSwmEQ91U37m3EGeVZ.oKZKpddFIuj
 .0adQmEjFikp2JDiP9gQAu1ujUVTvSMnVfK9G9mDNXW9m76Xwnpg1poH.k0lahNcJPdpnqkVayjd
 9I2gSHwCKgt3XH0bDYF5F8Lvhq.59K1E4pr68DWCS0lePUwydh5KorF4YF3yTHBlaCCUZsSQInpv
 8hsWuHG5sODdRf7iTWepPCp8D8xVdXSFhtjzpcaCQQmFA93DAr0l1bWqyKFu3bteZ7dQM9RNcWyT
 LcW1z415ymEhPV2tOpeQu4vD6YLy2PJ7TXQsRV0AEEU5E9PKccbJBf18m5MOvxypfAZZw9dUcHQ_
 oC2MGCs3OnNxLB_kNDTS9E3cFloTbuER0vTTK2NllajgqGYBXhBw.xlcZgBmnCG9gCZ5BIZFaMyw
 dUiIl3c.1rREF49fiMr.3wjJMzV8hnPBWI6U2gN8xcQLMHzLtrVViUd2xp5_iJ4psE7G0WB5o0zz
 0FcimF6Lmr5WdgjdJdUhbu5YqPmKGMMDYirUBeyHp1T0gcXOUQTqJhhXXBO3wqm1Pd9nYOs4I63i
 fNLSD1n39mIEqYTWgxM.AqQxbLaFEYpGuT619m9TquRfOVv2nYabQCz3067mTXR5Myf1Z4hf7M9C
 s2BoOapK7yqO5I1weA48sImD1cCDY3j9knH5F7pkM3NMz2oEaCFlkLUGqPXHyp2Mr4Omgjqi.B04
 tlQhAGd8C9kHekgyoBh8ruJR6eHjpmDj0y9uTIcKaer1dutuUndUlB6JDF8I6kun3cjVB_YJ6lVG
 yv2q0Pv1kla8CpC3mBMTYToSDzp6ZgOXi2Te78iKrvERDF704ut.81gJROMxhDIYoErxUAzehRHv
 OxGVvNNhagw9mKEHw4TwPGqxSGE_iJ64y51zUajz7.tPQ44ibw355qGwDItcBYGc_4KXrd9k04ly
 bKWFHfDlf8wfwAttTUGYTsim4AXfnKv9m17_.shlWMWeKM.WvQRAl5rTOmLM6..ZxVXpaxj6Lsk1
 F1xpe6TqiakUD5oI4E20DOrfjN4YKbFxeKEq09k2aw2WCiCP81dhzQQfZMrb.pWKJGa9sS0Ia9SE
 O4iv_5LdnjvtQ3nHkpTZiptuzLVHRK6drARZafxw1Ct4zu3f1PIjzcUxIJOFc7lSu4pk5yyDxLkL
 yUvA55oTVy.dwK7NS2oe7R0Ovn5Qamsso_w7JylSUQ2kKOV7cXrjrg1LNzNiBeqUxMMm4Yo5gIc8
 2Zr8YCMEwn6LvyhXHsu6byNTLp7QcFfOg5QzfEdQcTVfMwL6t_EBIC6M64D2vq.6cY2YP6gssFcJ
 db2uLwQgxz4XqCv0v1qyQyqeLXZB6azKf.2P6rH8.kokK2ZGdoihDRbvSPPKOwBdcFxtz87YnVxP
 GYSPWnPzt7ob5Q5Q46Hyuzm0roFhFMxAl608MBfmYJtf4YkvqblpfmUkjrixFmw.nXBklBdDn2ox
 jYqgyjh35PNsTyhz5UA6mQOn1Nipu_vTfZuZ_xyW86xS5GHBr_8Vq2YKWSTjidCcfk1BsxEg.OFN
 sJLhzy9..fgD3lL.ayTtu4kOpLsOjEJ6WavE1owp.jUogq1hheYatwlnBoQJhr203DHNptTuOGYg
 kTfMiOv8_3nAutm3flanr8oh7dC0b.w2DNI6b2HXRNu8xCyVqkzZvDDcTl1Bktv84jP7QYHDVK7C
 5T9DH4b6XEMWAdJv.gKRgvNRBDoUb.SN0T3gCR8Mlk6MGUDlPp6_cEySzFCIC1RPCC6WgbHRbYNO
 006Lt9b6wS0qexGgxRF3RybwTRJnO8XCBYgtI0B3tJkqbixK_6rRL0.iA2K.Fs9ex.J6jZh3b0hO
 f7Sobsw8oC_LV80BBZgT6ztaZ4un9LJvNNV32ggQDjxCexeO_OownH5w_UJYBperYXfEK1mb9iyn
 OnNsihGh45yEbPxRsNFHVlnIE2WvpFDCvmUxgGyUU0eiQaLeC8iMn0ZTavI576lCqVt_AUDeXH_E
 rkr4EKDCCJpcdWrSw1MvcF.dB6247obReAyjVGFaDyXzOgSb1S.UUc1d6FCcHsKQIp_.l74e0A9m
 ln5svpoDwoFrZHvn1D9tvo6Dy9bavr8.NggUJwKdqG7o1_CiawLNvaR6vywFQlTxw6mdMB8thMYL
 _HHsIhNFyHut00.UETNzZfwM9gvAOHvqgTW2OLwt8RkU2ZIGX4n.CIER0ITFS8RM5EcU9BiV3tSm
 XDEdX_M4RX7dGh0IzuGQVIcRvFisO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2020 18:06:02 +0000
Date: Mon, 2 Nov 2020 18:06:01 +0000 (UTC)
From: Mariah Blanchett Johnson <jones_desmond.j568@yahoo.com>
Message-ID: <1433791616.760840.1604340361182@mail.yahoo.com>
Subject: From Mariah Blanchett Johnson
MIME-Version: 1.0
References: <1433791616.760840.1604340361182.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16944 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36
Message-ID-Hash: 3DEQ3NIAFV3IATHVPCGZHC6IEGHQFR3S
X-Message-ID-Hash: 3DEQ3NIAFV3IATHVPCGZHC6IEGHQFR3S
X-MailFrom: jones_desmond.j568@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mb8958649@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3DEQ3NIAFV3IATHVPCGZHC6IEGHQFR3S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



From Mariah Blanchett Johnson
Hello Dear friend

I have sent you this e-mail for open discussions with you. I don't want you to misunderstand this offer in any aspect...if it is okay with you, I ask for your full cooperation. I have contacted you base on trust to handle an investment in your country/company on my behalf as a prospective partner.

My name is Mariah Blanchett Johnson It might interest you to know that I have US$3.600, 000.00, Three million Six Hundred thousand deposited by late father with a financial institution I want your partnership for investing the fund in your country/company. It is pertinent to ask if you can handle this fund/investment in your country, in any of this area

1). telecommunications
2). Transportation industry
3). Five star hotel
4). property
(5) Companies,

Meanwhile, I am very honest in my dealings with people and I also demand the same from you as a Partner to be. Can I trust you with this fund?

I want you to note that this is a mutual business venture there is a reward for your assistance. I shall let you know your benefit for your assistance as we proceed. For a more comprehensively about details of the fund, please contact me as soon as possible. If you find this letter offensive, please ignore it and accept my apologies.

Regards,

Mariah Blanchett Johnson
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
