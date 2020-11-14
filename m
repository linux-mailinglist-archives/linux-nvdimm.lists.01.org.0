Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82C42B30CD
	for <lists+linux-nvdimm@lfdr.de>; Sat, 14 Nov 2020 21:57:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25FAC100EF258;
	Sat, 14 Nov 2020 12:57:23 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=54.38.202.180; helo=cha7.b2blinkeddatabase.info; envelope-from=am-linux+2dnvdimm=lists.01.org@gmail.com; receiver=<UNKNOWN> 
Received: from cha7.b2blinkeddatabase.info (ip180.ip-54-38-202.eu [54.38.202.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B644100EF255
	for <linux-nvdimm@lists.01.org>; Sat, 14 Nov 2020 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=gmail.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:List-Unsubscribe:Content-Type:Content-Transfer-Encoding; i=tina.cloudmigration@gmail.com;
 bh=dIPeTwMDsB//pHV8LymHEEzcz7Y=;
 b=nN9xJZuqEYVQY5VJYwRL+XaMiDKjNiV9WwE7M/72b6PaH12V1XcJtW5rvDCd92G+aJc4OMkJ+0kL
   JJLsOotjVzl0rM5s0QzDg3UPoJ//9YOmpmyQSCCwEJccYrGe7wm1TzbIJplk3dY/FgwNQNuvZ0IH
   QNCaiC3hC5bXAKSgqW/L65c9ExlCL+JA//WKcSyIznKnrdzIsIYADf+NzFI1rOFfj5Lsuj+DpkG9
   1bEeINLN/0pdIRu1kfhDkpCp46+qxCzGE/XPE/gJJ4reDRxrZGnRuKpF0/v37lmi7Ro752i0Nv/K
   J12BaoavebQEA6+/nWvV2srmPbVjLBkRW30bnA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=gmail.com;
 b=lmA1oOPySURIHyPXWGSWZkynj+EHg3MCKZ1xNvaiKloWzkVJKSgV1LlrG+sWkInIKB75uyrXsnzB
   QWhWUS+AQN0yeY2SL/7I0XxYN8YipvF8sLLHUNuIt0KetZ16fDOGSUPniF/r1Xa8UShqHjGUmZFm
   bymsYKmZq3AzJO31EYkmAbsRieqxCoTJTMr5rMQRS9YF98MVkV15vRQkMh+zFxn4ejZ0C+PIUA2m
   k0PhdUp/Q8ZGzUq0l6zYPi1lK0JgCd4SFXEF33ZX1LP6NCVl1vyFxmbaYByAaBj82kwbfcbDUQKf
   Fi8QMlJhEbX6MBF9b9JxWibF2F3s5wdtg9+UZg==;
Received: from b2blinkeddatabase.info (127.0.0.1) by cha1.b2blinkeddatabase.info id hm12b1i19tkt for <linux-nvdimm@lists.01.org>; Sat, 14 Nov 2020 20:57:17 +0000 (envelope-from <am-linux+2Dnvdimm=lists.01.org@gmail.com>)
To: linux-nvdimm@lists.01.org
Subject: RE: 10K LinkedIn Leads at 500
Message-ID: <167d45d116adcc91ec9289438f9e9eb3@b2blinkeddatabase.info>
Date: Sat, 14 Nov 2020 19:57:31 +0000
From: "Tina Joseph" <tina.cloudmigration@gmail.com>
MIME-Version: 1.0
X-Mailer-LID: 12
X-Mailer-RecptId: 9652722
X-Mailer-SID: 6
X-Mailer-Sent-By: 1
Message-ID-Hash: KIKLX5WMXOCTJZXXVT6S2N7NCADE2T2O
X-Message-ID-Hash: KIKLX5WMXOCTJZXXVT6S2N7NCADE2T2O
X-MailFrom: am-linux+2Dnvdimm=lists.01.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: tina.cloudmigration@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KIKLX5WMXOCTJZXXVT6S2N7NCADE2T2O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Your email client cannot read this email.
To view it online, please go here:
http://b2blinkeddatabase.info/emm/display.php?M=9652722&C=eoase7zvrzltf9tgdywzg79p92ka1687&S=6&L=12&N=1


To stop receiving these
emails:http://b2blinkeddatabase.info/emm/unsubscribe.php?M=9652722&C=eoase7zvrzltf9tgdywzg79p92ka1687&L=12&N=6
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
