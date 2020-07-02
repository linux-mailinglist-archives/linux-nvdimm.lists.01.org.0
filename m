Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A082119FD
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Jul 2020 04:15:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0E8E1103E37B;
	Wed,  1 Jul 2020 19:15:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=104.168.141.202; helo=serve0.pbproducts.pw; envelope-from=sr@pbproducts.pw; receiver=<UNKNOWN> 
Received: from serve0.pbproducts.pw (ns1.pbproducts.pw [104.168.141.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79EC411022293
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=pbproducts.pw;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 i=sr@pbproducts.pw;
 bh=Gv9K83qqaAU8xowMN61YACh7chtzY1QF1Mi6H57XpPY=;
 b=Gypi1hgvhjj6xPVdONrxFGehCOCWfRPWrUiJojKR3wfiZowgvC4kIYfl4H8wb0YbSTrCG5POjVf6
   O0IsG631U7SDl2l4LporoTQM02L00m2q28B7njLRJ4LtVxUvtwGRXXrsOqiZe2rBR+L6Wdvjmgzp
   qFLgf8pFeyIU/wnSTrw=
From: "DHL" <sr@pbproducts.pw>
To: linux-nvdimm@lists.01.org
Subject: =?UTF-8?B?6ZyA6KaB6YeH5Y+W55qE6KGM5YqoIC0gUGxlYXNlIENvbmZpcm0gWW91ciBTaGlwbWVudCBBZGRyZXNz?=
Date: 01 Jul 2020 19:15:37 -0700
Message-ID: <20200701191537.49587F01F5FF5214@pbproducts.pw>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_521D16AA.FA0F4D06"
Message-ID-Hash: PWD2HAEY75SGRCTOXMLIG35EFFUGAWX2
X-Message-ID-Hash: PWD2HAEY75SGRCTOXMLIG35EFFUGAWX2
X-MailFrom: sr@pbproducts.pw
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PWD2HAEY75SGRCTOXMLIG35EFFUGAWX2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0012_521D16AA.FA0F4D06
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

------=_NextPart_000_0012_521D16AA.FA0F4D06--
