Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E523A8C9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 16:46:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CD0D1294F0A7;
	Mon,  3 Aug 2020 07:46:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.131.123; helo=sonic311-13.consmr.mail.bf2.yahoo.com; envelope-from=lina.williams061@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 867921294F0A4
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596466005; bh=xSUmQ60kQQY8IXDFaVmjJ+tg9o6fEd4c51Pa8GwuPSY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Z2nGIJo+Cp5kkt09hlR1x+7ZnSbntGG8Tik6GaQ8S53/QZnB97HdamXTMw7PiiKKbIbNDyn2Nt+xSIdar5U3Cm5pAF+AMPddntWHlkjLHICzuOQeAm/+xtdzWveYN2MOrgWODOU+a/ba1ou5DxTGmMUgUOXuqD+oYKG095BhFnBUUD15gRQFs7ba5AdjtGX8/oERTBnSp/+D/RXvmu1S8vwp7btBnZCEdW+YjkXJql6ROCaYvm/sMHoDv3NFHi/7LtAa0eBAW7Edy8248/inrX82k1yBl0/JU7TAVUDQAEuoiAWdflfeesYpSI9tO4IYF4vGDt0gebginL2il8NNFw==
X-YMail-OSG: Agd1P_wVM1moCa1sABGQK6omg9LYn.tUWEl.ejJpf.e7YCiU9NG7Z1roxcZO7yL
 EsXjgCtioRH32nlHNswcCc4uExP3hM8p1yQLNkp4fS.WNW.CpSvNSYh6Z3wL8Fevv0JTOAP55ddb
 7ePm5dt5vSZPqVoUbxj6LkegDCOoJLQlUfsdEX7jkflz0nQMcGW499Fg6gNcXiFxFagV98W4xkQj
 0Xv1odkNGHbqE6vtrDf0IAZ20v3Zti_U79XETxIL3jvb5rVV8suElKq4crVoV8ud2ZW3YmMyQFfg
 VpDN.VrJEA8nnwNwm5F9PnAHG.5omgM8wWLG2tDPA2.UrJ0f6TudwM_kCoPNMzSmiTo6WSw5u1YE
 YN9v9hKP6AuhlyFPIzlmuETo71M.9G8Qiqx.IG4j_9wlmkLCpx3vdJOP1Hlav6onCkTqyAP0t1dl
 z3KHjQNLWbsYGLCIwAckg.asc3ClMUUlxgGTrMDyjWVpyRgiBHdduaiSknvZbUMNNboaMrm7U8PN
 zzgkJS1GUU0nTKbvwv3XMtTA4jMGE3MJ4tOobCPjIfzIS1_J4sorNNhNKAJFjpJSfAEDoJWzzLju
 mvTHG2rHEK4gpUT0yU8clCVHz1s5I55WL.dTTJSZEXgSCyiVDWpxTm3z6_eylEdYeTQfcFP5TXdr
 fg46XkkYoQArv12hLq9y90imaRQGhouBUdcyytwsefjlD5bOsNSaSp5Tvc3hd6iA2Oq9pt6HflPc
 9zlt1nNvvV_XWpr_YiwKDSF4jlHis4AcG2zvI2v0wvoeh31EA3Ga2z6T2puqclESQfO9CKeaFkU7
 LcPDSZzRFBCfR2D_t0Whs8H4RpnmTqca0Vc5ohOqix_hG06Pqs4GWRYmC_DEww0SCnp.R5yOu.B6
 boY5caR9OTUbajAR4b1rCkM_qrHH7OA.aqflg3HsJgPzGSsZQHOLm5gKFz6SALlGfH0iM7BSP5HE
 E8g2PQeXHw4LZLcTtbkzTdUpLnJXTHeQwE.5sda0ZsvRzL6Dm5SXK7W6pNkHrEVivnFIcJByy_6z
 W2so3aHj6mnMqJc4Wpa44Zo7ZAETcOv_qDTSK0LvJQEM6Nw34jHJJhWTew3w3E_vIAxhCjNFsKF1
 VpRSDXIvaATlsl_2UwRHd6rAre5ldOreVKWcw9CQSBIpBMid5.uAV70KlEEEeSJr55zHm7bDhSUW
 K1uivgi83yIlkdVEYfrggMms3GWFEwU81vkpFBrQQruFZP.WnBTvXaRTgxGce4NCLqant4xqUIsN
 ISH0984kKkPypSmulJ0I_3U7MWVbIqMv_5qFrp1jHT3Ats0ke_zv3S0IO9D6RfS7EUxfYv5xAAk6
 V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Aug 2020 14:46:45 +0000
Date: Mon, 3 Aug 2020 14:46:40 +0000 (UTC)
From: lina williams <lina.williams061@yahoo.com>
Message-ID: <818785484.7814395.1596466000501@mail.yahoo.com>
Subject: MY LOVE,
MIME-Version: 1.0
References: <818785484.7814395.1596466000501.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
Message-ID-Hash: LVKM6Q3YIACPYPOB7ECWR6YOU7GYXK5U
X-Message-ID-Hash: LVKM6Q3YIACPYPOB7ECWR6YOU7GYXK5U
X-MailFrom: lina.williams061@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: lina2020williams@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVKM6Q3YIACPYPOB7ECWR6YOU7GYXK5U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

MY LOVE,
My name is Lina Williams There is my email ( lina2020williams@gmail.com
 ) I pick
interest on you. I will like to establish
with you. I will introduce myself better and send
you my picture as soon as I receive your reply.

I am looking to read from you as soon as possible.
Thanks.lL

LINA  WILLIAMS
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
