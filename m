Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED63692B0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Apr 2021 15:07:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3045C100EAB5E;
	Fri, 23 Apr 2021 06:07:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48007100EF25B
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619183269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZiEIV54Feydxm3In/brZNAh1w14oc1bLXe4KF6wMdTU=;
	b=VDf49I1b+TkKd1OZo2IxPrfagEITSaiyka0c7BuwGWIKmZZdgc5RpwsTcd5DGySsfaKMPW
	Z2o71DgguHYMkxXpJqiMhA05mNCOsj9+YhqmkGsMeNZYF3pxszfs7i10LrGJaxVxSufA0a
	HukZVeIm8w0Rb6GhYZbPQ8SJzqYy/10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-K22UzCxtO7iDmCD0Jo1zXg-1; Fri, 23 Apr 2021 09:07:46 -0400
X-MC-Unique: K22UzCxtO7iDmCD0Jo1zXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E6D343A5;
	Fri, 23 Apr 2021 13:07:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-86.rdu2.redhat.com [10.10.115.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 123201B5F0;
	Fri, 23 Apr 2021 13:07:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 99F7E220BCF; Fri, 23 Apr 2021 09:07:37 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH v4 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date: Fri, 23 Apr 2021 09:07:20 -0400
Message-Id: <20210423130723.1673919-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: ILMVF3S72XB7MYWWBWK544LZUWE3OPHQ
X-Message-ID-Hash: ILMVF3S72XB7MYWWBWK544LZUWE3OPHQ
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, willy@infradead.org, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ILMVF3S72XB7MYWWBWK544LZUWE3OPHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V4 of the patches. Posted V3 here.

https://lore.kernel.org/linux-fsdevel/20210419213636.1514816-1-vgoyal@redhat.com/

Changes since V3 are.

- Renamed "enum dax_entry_wake_mode" to "enum dax_wake_mode" (Matthew Wilcox)
- Changed description of WAKE_NEXT and WAKE_ALL (Jan Kara) 
- Got rid of a comment (Greg Kurz)

Thanks
Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
