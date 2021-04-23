Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F73369C87
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 00:26:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 535A7100EAB07;
	Fri, 23 Apr 2021 15:26:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=82.94.250.64; helo=mail.sielsystems.nl; envelope-from=willaseymaria=gmail.com@via.sielsystems.nl; receiver=<UNKNOWN> 
Received: from mail.sielsystems.nl (mail.sielsystems.nl [82.94.250.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95719100EAB05
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 15:26:26 -0700 (PDT)
Received: from ac2.sielsystems.nl (ac2.sielsystems.nl [82.94.250.183])
	by mail.primerelay.net (Postfix) with ESMTP id D902943B57;
	Sat, 24 Apr 2021 00:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sielsystems.nl;
	s=20191209; t=1619216431;
	bh=qIrkC5AGT7VjC9+Gw9IjnlLblop8oH4upks+1RFJFVI=;
	h=To:Subject:From:Reply-To:Date:From;
	b=HhiteC6sHg/IkPqe4g7vUtrEQHg7L31uetKAeWp1v6RPVpJOlR8gFuwS1w4ekq5fS
	 lJCyGT7zS78317aQotOeKIOJBLFIpR6WAXm6YjXgL7TwRp00mnsl5W+3GflNBCTI7O
	 0a9ElH1c/apip7agrumBSKMbuAQ862tiplCXHipHgCW2//G3CKTcMQsKCtJhwn9BOr
	 rqWmym9KhCzIBZOA+IJPfL5kWnRwYYBp03fG/ILekrsfowRxUlaSJZ3NlGXTqptNyh
	 xzDS7RLywiMq8+LflWLKwgWf0k8wZsqasM0IRmO7Ag2L2/7npWU8mgW2maWJyrNHy/
	 6Qaz80AWqDbsQ==
Received: by ac2.sielsystems.nl (Postfix, from userid 5001)
	id 7EE75ABC047; Sat, 24 Apr 2021 00:20:25 +0200 (CEST)
To: willaseymaria@gmail.com
Subject: OFFER
From: Maria <willaseymaria=gmail.com@via.sielsystems.nl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="75be7e52618369fb1ccd0bba4dff0314"
Content-Transfer-Encoding: 7bit
Message-Id: <20210423222025.7EE75ABC047@ac2.sielsystems.nl>
Date: Sat, 24 Apr 2021 00:20:25 +0200 (CEST)
Message-ID-Hash: 33K6TU43W7FPLCTN7YAKPCJKOZOUFQBS
X-Message-ID-Hash: 33K6TU43W7FPLCTN7YAKPCJKOZOUFQBS
X-MailFrom: willaseymaria=gmail.com@via.sielsystems.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: willaseymaria@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33K6TU43W7FPLCTN7YAKPCJKOZOUFQBS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>

--75be7e52618369fb1ccd0bba4dff0314
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--75be7e52618369fb1ccd0bba4dff0314--
