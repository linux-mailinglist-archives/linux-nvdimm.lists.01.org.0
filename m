Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE3231CC9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 12:35:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AB721269EC08;
	Wed, 29 Jul 2020 03:35:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.14.98.202; helo=us-reseller1.managedns.org; envelope-from=info@bsel.com; receiver=<UNKNOWN> 
Received: from us-reseller1.managedns.org (202.98.trunkoz.com [103.14.98.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 694811269A4EA
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 03:35:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=bsel.com; s=default;
        h=received:message-id:from:to:subject:date:mime-version
          :content-type:content-transfer-encoding:x-priority
          :x-msmail-priority:x-mailer:x-mimeole;
        b=ppsXOcTToLB9ImDEvuFxPFoDBwYNnDUatFNdH7Gnes0dFEvX88H9ykFzTKL38/DwI
          krz8Ptnc48mI2PRkdzmdS/WATaw/ANM5sNJhY/f/pmyfhhriThs9LGRcPRoAxueGf
          vm6lDp8wjwEdYSK+yKedjLaHiTOBpMZm6IOALtsZs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bsel.com; s=default;
        h=x-mimeole:x-mailer:x-msmail-priority:x-priority
          :content-transfer-encoding:content-type:mime-version:date:subject
          :to:from:message-id;
        bh=T4rEOETX+pXoWB7FKEPNcosFRtEOilKMBa+VGjbhlpk=;
        b=XMLNyFI5tBNvifX5MPd0IimwOH4617LKM8CT2+5iSDLzeIHmBrC+fXb+j4SUJrVH/
          CTbIVzmreEj9jbP9QbrR9WQQP+1mJ/GPL+4avPiejAG/MjN9eIzG2xqxFpnthsWoe
          m0/4tX9ksT3T/T1J8idqryHhdpi1i6pIHcCi85N4o=
Received: from ncmiem (225.132.70.125.broad.cd.sc.dynamic.163data.com.cn [125.70.132.225]) by us-reseller1.managedns.org with SMTP;
   Wed, 29 Jul 2020 06:34:22 -0400
Message-ID: <09FB324E976BD3DC3CB667761B507FCB@ncmiem>
From: "wihvenh" <info@bsel.com>
To: <account@onlyou1999.com>,
	<linux-nvdimm@lists.01.org>,
	<shb@jinbaopack.com>,
	<linji@mikeo2o.com>,
	<xmzhao66@sdau.edu.cn>,
	<yzx@k8soft.cn>,
	<info@boyaprinting.com>,
	<zhuangqin@anta.cn>,
	<gzcw@aotaihua.com>,
	<william@kwgproperty.com>,
	<tuyan@rakuto.com.cn>,
	<ylmaster@yulian.com.cn>,
	<steve.shao@serviceindeed.com>,
	<service@yikaida.com>,
	<tyler@asana.com>,
	<terrymao@boyaa.com>,
	<hil@almaden.ibm.com>,
	<zhouyuehua@shengyuan.com.cn>,
	<cotton@chinatex.com>,
	<001@chinaimd.com>,
	<ab@cdyad.com>
Subject: =?gb2312?B?xb7FvtfUxcTK08a1?=
Date: Wed, 29 Jul 2020 18:34:12 +0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: F6IGN5BXSWGYIXCDZJCU4SXW3QZUGLJI
X-Message-ID-Hash: F6IGN5BXSWGYIXCDZJCU4SXW3QZUGLJI
X-MailFrom: info@bsel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F6IGN5BXSWGYIXCDZJCU4SXW3QZUGLJI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4403882941939552964=="

--===============4403882941939552964==
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTEuMDAuMTA1NzAuMTAwMSI+PC9IRUFEPg0KPEJPRFk+DQo8UCBhbGlnbj1j
ZW50ZXI+PEEgaHJlZj0iaHR0cDovL3Zpa3JhbXZpcm9kaGlhLmNvbS8iPjxGT05UIA0Kc3R5bGU9
IkJBQ0tHUk9VTkQtQ09MT1I6IG9saXZlIiBjb2xvcj1kYXJrYmx1ZSANCnNpemU9ND48U1RST05H
PjxFTT5odHRwOi8vdmlrcmFtdmlyb2RoaWEuY29tLzwvRU0+PC9TVFJPTkc+PC9GT05UPjwvQT48
L1A+DQo8UD48Rk9OVCBzdHlsZT0iQkFDS0dST1VORC1DT0xPUjogb2xpdmUiIHNpemU9ND48RU0+
PFNUUk9ORz48Rk9OVCANCnN0eWxlPSJCQUNLR1JPVU5ELUNPTE9SOiBzaWx2ZXIiIGNvbG9yPWRh
cmtibHVlPsW+xb7X1MXEytPGtTwvRk9OVD4gDQo8L1NUUk9ORz48L0VNPjwvRk9OVD48L1A+DQo8
UD48U1RST05HPjxFTT48Rk9OVCBzdHlsZT0iQkFDS0dST1VORC1DT0xPUjogIzgwODAwMCIgDQpz
aXplPTQ+PC9GT05UPjwvRU0+PC9TVFJPTkc+PC9QPg0KPFA+PFNUUk9ORz48RU0+PEZPTlQgc3R5
bGU9IkJBQ0tHUk9VTkQtQ09MT1I6ICM4MDgwMDAiIA0Kc2l6ZT00PjwvRk9OVD48L0VNPjwvU1RS
T05HPjwvUD4NCjxQPsW+xb7X1MXEytPGtTwvUD48L0JPRFk+PC9IVE1MPg0K



--===============4403882941939552964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4403882941939552964==--
