Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0829E8CC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Oct 2020 11:16:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8E1D16381CD6;
	Thu, 29 Oct 2020 03:16:51 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+253bd1d761fb220e0d1c+6276+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5663116381CD5
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=oDJgefKs9xoc4uZr+/1eK6hrCKP+Vr9doGZVzreNMJQ=; b=etZnIfsbPOgHfGNEo+WrBNGg68
	psjP8u9zcw9rY93vQrENi8S9JJWh78rQwpB/1s67UrtzF3D1mzqU67tjBGqCXgITiHmzEzjvg/XTm
	xanT4BVibDehZMYHReOnVQwq+5Jfc5vj+Gl8Xk649dMRLl/zTWK1ObGjxOgKE0E4UB/QWyLvxlOxj
	9j1MojuGs4Hw/VAfeQ7OT28ty65X1kRSFX15YfQYY2VAw+ZsEy0gldW/7kwmEfiVSOiz3E7vmz8sv
	zOsd8qkez+eKsy8IDwRhqHsgB2nbHgAno0OQtIf8s8HCAK0UI+dGhu2siVirEy5HQ/gT3OWqk1cvq
	EnOa7oog==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kY4z4-000453-OP; Thu, 29 Oct 2020 10:16:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: simplify follow_pte a bit
Date: Thu, 29 Oct 2020 11:14:30 +0100
Message-Id: <20201029101432.47011-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: UKGKRI6EQHSDW6VQ555QI6F3DGGTUY5O
X-Message-ID-Hash: UKGKRI6EQHSDW6VQ555QI6F3DGGTUY5O
X-MailFrom: BATV+253bd1d761fb220e0d1c+6276+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UKGKRI6EQHSDW6VQ555QI6F3DGGTUY5O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

this small series drops the not needed follow_pte_pmd exports, and
simplifies the follow_pte family of functions a bit.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
