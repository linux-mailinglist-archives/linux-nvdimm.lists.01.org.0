Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B4369C7E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 00:24:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24422100EAB05;
	Fri, 23 Apr 2021 15:24:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=82.94.250.64; helo=mail.sielsystems.nl; envelope-from=willaseymaria=gmail.com@via.sielsystems.nl; receiver=<UNKNOWN> 
Received: from mail.sielsystems.nl (mail.sielsystems.nl [82.94.250.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F390100EBBCE
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 15:24:46 -0700 (PDT)
Received: from ac2.sielsystems.nl (ac2.sielsystems.nl [82.94.250.183])
	by mail.primerelay.net (Postfix) with ESMTP id 90EE843468;
	Sat, 24 Apr 2021 00:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sielsystems.nl;
	s=20191209; t=1619215893;
	bh=unjD//lLOXPCmhgHtfupCY1tVcjlFUKfw88VBGE+00g=;
	h=To:Subject:From:Reply-To:Date:From;
	b=tghPfayOpDj2UyvySMvByWpu4GgRBDVfvJ1UbGVLiuAWNl7BbgWpZMrEs8xHNbeEg
	 Oe8DxlHfYHCEaL+XP9bnucOHwJOCujTvjxjUOYYHJPWbiy+fyhJNXZXPlHimq9ncJA
	 czuDcyZNU815lQhN/OPN9GNUke21kU9FgUosw0SPh6wVZqHh11UF4jratNCzOGbANG
	 WAQzSnr1Ha9njFZYbeuXv4UNK8AgbMjLdoTONR36/8gXuxbFlfoe3o8expesNq+DN9
	 cqrYCBr9zLxkhStZJ3a/aQOMh/89+9Aj027WR7TyL3/QMQhJKm4tXq/eZKU3dGiJjE
	 +dNjbcDycYZHg==
Received: by ac2.sielsystems.nl (Postfix, from userid 5001)
	id 2D17BABC047; Sat, 24 Apr 2021 00:11:29 +0200 (CEST)
To: willaseymaria@gmail.com
Subject: From Ms Maria Willasey
From: Maria <willaseymaria=gmail.com@via.sielsystems.nl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9486464d00789289c1762290aba9d8d3"
Content-Transfer-Encoding: 7bit
Message-Id: <20210423221129.2D17BABC047@ac2.sielsystems.nl>
Date: Sat, 24 Apr 2021 00:11:29 +0200 (CEST)
Message-ID-Hash: GQPHFEQZOLV37XLESXSKOLZSMC7IB26P
X-Message-ID-Hash: GQPHFEQZOLV37XLESXSKOLZSMC7IB26P
X-MailFrom: willaseymaria=gmail.com@via.sielsystems.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: willaseymaria@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GQPHFEQZOLV37XLESXSKOLZSMC7IB26P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

--9486464d00789289c1762290aba9d8d3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--9486464d00789289c1762290aba9d8d3--
