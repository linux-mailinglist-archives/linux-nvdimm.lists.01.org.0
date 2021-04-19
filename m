Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76F364D28
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 23:39:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A375100EB859;
	Mon, 19 Apr 2021 14:39:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7A2B100EB855
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618868344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HEv6wLVOqLEkA1FkObpOLdW0h1KNpD964gmCWJcGub4=;
	b=GuE7DuXDs//6C7RzTFS5evhFVv8+iBInuOA5qhH+Nptmt488eYvjff/uqtqDrF7LtlNhui
	O8FR3gF5tiIkG8JO16dMVyma+vpBhfOyjH0S+CfPuPSRvKOikS3F9BOq4QkJ459bE7yrtN
	PH0JBrwHYXbhwbnAHtyrtiiU+XbjHxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-HkjxGxMeNaeuxa9XXPlvZQ-1; Mon, 19 Apr 2021 17:39:00 -0400
X-MC-Unique: HkjxGxMeNaeuxa9XXPlvZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D091006C82;
	Mon, 19 Apr 2021 21:38:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-35.rdu2.redhat.com [10.10.116.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0513319C66;
	Mon, 19 Apr 2021 21:38:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8FDA722054F; Mon, 19 Apr 2021 17:38:52 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	dan.j.williams@intel.com,
	jack@suse.cz,
	willy@infradead.org
Subject: [PATCH v3 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date: Mon, 19 Apr 2021 17:36:33 -0400
Message-Id: <20210419213636.1514816-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: CVHCJSGCG73OFJ7SEQJW52LU3INZJSRX
X-Message-ID-Hash: CVHCJSGCG73OFJ7SEQJW52LU3INZJSRX
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: virtio-fs@redhat.com, slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CVHCJSGCG73OFJ7SEQJW52LU3INZJSRX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V3 of patches. Posted V2 here.

https://lore.kernel.org/linux-fsdevel/20210419184516.GC1472665@redhat.com/

Changes since v2:

- Broke down patch in to a patch series (Dan)
- Added an enum to communicate wake mode (Dan)

Thanks
Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
