Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA3258C8E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 12:16:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 275D21252D375;
	Tue,  1 Sep 2020 03:16:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F95F1383DA9F
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1598955344;
	bh=qv4Z6JnkawuqyBfR4IQjNIZNVlU1r0SgVqjymqZzG4I=;
	h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
	b=ADMpk0ocDtitLLFyTqokXMTpnVJ9+AGkWGU3DNGAwAW1lFTbs1BmblmzSDdYm0BoA
	 8vNHBppNZykkmbGvynGoM1nZLR3k84PIhpksaV3vPYgdDX8pdCzH+zPTInJlpKFFb3
	 RN5YdcexfC2byHedRn/ImjBSauznYT7ZsFtoY9gk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.94.126]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1km6tf0o31-00Zvpd; Tue, 01
 Sep 2020 12:15:44 +0200
Subject: Re: [PATCH v4 0/1] libnvdimm: fix memory leaks in of_pmem.c
To: Zhen Lei <thunder.leizhen@huawei.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901081450.1969-1-thunder.leizhen@huawei.com>
Cc: Oliver O'Halloran <oohall@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <9d82bd85-5d6c-b8fe-15c7-c87348aa7a3a@web.de>
Date: Tue, 1 Sep 2020 12:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901081450.1969-1-thunder.leizhen@huawei.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:lpXKCuzjDyVPsW7iA39HUwuNL4TBAXldxm/UDMiYa8RpljqzH/X
 1vblF597P+lJJ8AB282XEHSPi145EmKDpUMnHBv0BbLTz8DhtiDWgqlhOEcCEVo1EEu7f//
 Xt7oQqE/2ddAac7Bpq5qZd3Vb/muI7jK94mV5mB2sBSonDN00l9z1A3VJvB1+VaLxo5uaRF
 XeTbvy80jTE/DlLiEwgMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vt3Q8F2c3gY=:tWIQSHcI738xCPGcmV+Fsr
 oXjk4tVpxo7Im2UXuhuToIziHIsWS3GhhG71wEtLC8QHHO6b41JeB3lgcTHHw9bgi/lW6WNiX
 7pCdiS7glvP9ccx2fNOGoK6zOqnwDub00kso9n03C2bv4dRNJYPvfaLN+fKMtQKqK4uXcNC8s
 KwS4UIos/D4uO0eYfQrSQUrlxwH6mX24YqzejOqP38oGwLf5LNj/RwEWO6Qg/u/dy+FfQsFIu
 ZTsZDTeM4rZGhbEchcAVdoOX7Zkpv+HqMtmNk3ZznIcPHQSMfh4pJ/ZdKF0XJvhDU00CLMslE
 8sQiQSnSRzFEypzpHgTbOG1sfg8NqKf6Inig1DpBVz+Dap11tbWqJy9o/6epdVC/PuYMDdRao
 LomdRj+B8k8wRexwo9vBNSP7Rr8KTPLE7rRdUw4EbjEwjRIIOT/5drvIPfYDgtYKFPxfjY/nD
 Od2UkKVcy0gLI5QRzQ5RQk9rW8AE3ZJXHSb/FdaZmzpCpHpz6aA9n9ZjEWmc+jtabg9KucaAD
 xYvBIz6zAX0p7loAEADQeSA4veSRv5rPo1A+55t9/ccNM3nP3WB01o33Wyx/8E0S7EanVsmTy
 4VJtWMmQh8HGcylri8yHEdIFB31fvpM+lbxKYRpoLs63PPbLDYfVYBnXTItliSxbR12KQa5iW
 65TaPEupvnWM6Q57Sg/wABJNj3l8SbKNcqgOd3M5LP3xiMd7A+P3Uqw2LoUb0YAmm4kUWPp76
 RUoADpdNEIu6b4EJGut5M4I/CUvlTed1rzsVedwF1DaS8/r+4IKeK81J8K/Uyk38wu5MOYwEU
 Xr7m8k+o1LPOTRSGIGVMFJVG9p69Bp1lcmVEWKHMiRIxp2BWq7DWvdxrjYwkDyMD5TBcARoi+
 jS6ik76e+FXm9fpB9YRMgejMu/jPXlpXMwtMH7a+KJk4gjDpfZpGzaPnl4hwS+oe7PwZVIPgI
 IGCP5ohIjXexwM58fAope1thsdc0fUjj0hbHtl0rKHXuiyWutbihMEC58W4Lxa7D4YYXjjLk9
 WkCPNyk9HElXgSNaKxWe6cax8wWe92FN74cLixn/MIlDBsKP7+dTXd8bSHgjQnICSOoEqdKl2
 P+yXQzkPdUxzZiqOQyJYQLzPvWVlWUvBqC6A4PZMijKnrOACIe5HiuovnfX9JBStag/G3HgRZ
 E1NGAvamaV7/xx/PubTodCMian4BbitASRRisPPm5rfGOQSE4khOixvpqDB1xWn/FAIzWpZAq
 Qqwu2az9FhClx13igrpr3Z+4IdnQcY2MHfJjlEQ==
Message-ID-Hash: VBR5P3TZMP4ZAMUOZVM6RI6BWRRJKHZQ
X-Message-ID-Hash: VBR5P3TZMP4ZAMUOZVM6RI6BWRRJKHZQ
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VBR5P3TZMP4ZAMUOZVM6RI6BWRRJKHZQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> v3 --> v4
> 1. Merge patch 1 and 2 into one:

How do you think about to omit a cover letter for a single patch?

Regards,
Markus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
