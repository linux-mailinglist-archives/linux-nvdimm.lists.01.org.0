Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4B10E29B
	for <lists+linux-nvdimm@lfdr.de>; Sun,  1 Dec 2019 17:31:05 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1FC81011361E;
	Sun,  1 Dec 2019 08:34:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=187.141.35.197; helo=mtax.cdmx.gob.mx; envelope-from=aac-styfe@cdmx.gob.mx; receiver=<UNKNOWN> 
Received: from mtax.cdmx.gob.mx (mtax.cdmx.gob.mx [187.141.35.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B0161011361D
	for <linux-nvdimm@lists.01.org>; Sun,  1 Dec 2019 08:34:23 -0800 (PST)
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
	t=1575217591; h=DKIM-Filter:X-Virus-Scanned:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:
	 Content-Description:Subject:To:From:Date:Message-Id:
	 X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
	 X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
	 X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
	 X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
	8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
	8=; b=RxenI3z6o3k2qAKywt2Qv+DsedKPW5/PVdqJ3mlxEJrk
	RBeAabvNOgP2XP18jviVJ14wF9SzHqMOknLPBgiYsRYbg6ZGL6
	o3rdzoNjhHQCsxHKS/bjTm06d8PtdVsnZt1RTt4X+RwiycAYuI
	cZwVHspU8tFUYLb1CBCVa5pVb1o=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
	(TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
	 id 217f_5ff5_7b928ed5_50eb_49ff_a2ec_0f7bedf8edde;
	Sun, 01 Dec 2019 10:26:30 -0600
Received: from localhost (localhost [127.0.0.1])
	by cdmx.gob.mx (Postfix) with ESMTP id AD5C31E2192;
	Sun,  1 Dec 2019 10:18:16 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
	by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 04Fl1Faz5swS; Sun,  1 Dec 2019 10:18:16 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by cdmx.gob.mx (Postfix) with ESMTP id 439DF1E27AB;
	Sun,  1 Dec 2019 10:13:05 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 439DF1E27AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
	s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216785;
	bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
	h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
	 From:Date:Message-Id;
	b=iEUmqUogGpJbRvKsG2Ptc4/98wSA/EjGYuBoN8Icd34qjhSUHs/RhVHNqponGQCVi
	 KcCB78RgsYTW1HSSXjP70ITD2jYA5kZNn37PMpyWsNF/qeNtdmJ+gok8VMmrSejvSX
	 6hken3Qr02z5bGoeT7elmEfCDNi5pfyvo/XHjxjs=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
	by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MPa_2GA6gllb; Sun,  1 Dec 2019 10:13:05 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
	by cdmx.gob.mx (Postfix) with ESMTPSA id EE1691E2F7D;
	Sun,  1 Dec 2019 10:04:24 -0600 (CST)
MIME-Version: 1.0
Content-Description: Mail message body
Subject: Congratulations
To: Recipients <aac-styfe@cdmx.gob.mx>
From: "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date: Sun, 01 Dec 2019 17:04:17 +0100
Message-Id: <20191201160424.EE1691E2F7D@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=R5pzIZZX c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 5b9e3ed5.0.72334611.00-2347.121910817.s12p02m001.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
	WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949749>
Message-ID-Hash: P74ACL7YO2FET2QQN5LZMOEFNKFNXYP5
X-Message-ID-Hash: P74ACL7YO2FET2QQN5LZMOEFNKFNXYP5
X-MailFrom: aac-styfe@cdmx.gob.mx
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P74ACL7YO2FET2QQN5LZMOEFNKFNXYP5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact them with this email for more information 

EMail: allenandvioletlargeaward@gmail.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
