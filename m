Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30736DF52
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Apr 2021 21:03:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39629100EB844;
	Wed, 28 Apr 2021 12:03:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F40D100EB83C
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619636613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MLrGc/XGIkKevghVxu7iMDBjiIgG5ql+h/MHMCYHiOM=;
	b=Y5aIegwwrb3C5kvrWuzQdU/KjG4sDPu2NW5WbRLqoQmLWRjnMQWVhCfsU3L2UOOEmlzuv4
	wY1Jl2JiuVxScb6JBlIETzxiEVDoc3/XrUaFf3H6Uzr9LlWZcJjLGRH7QWNBmOg+0I7gXI
	2deN1iiJXjFFlpJxUh1OVs95U1o5Xic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-rjo6gzNJMYSjlXBdKxL2Rg-1; Wed, 28 Apr 2021 15:03:29 -0400
X-MC-Unique: rjo6gzNJMYSjlXBdKxL2Rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 924BD106BB3B;
	Wed, 28 Apr 2021 19:03:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCEC10027A5;
	Wed, 28 Apr 2021 19:03:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 2A155220BCF; Wed, 28 Apr 2021 15:03:24 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	dan.j.williams@intel.com
Subject: [PATCH v6 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date: Wed, 28 Apr 2021 15:03:11 -0400
Message-Id: <20210428190314.1865312-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: A26WOGOIX45K5ZBZVAC66H66APHZ42CQ
X-Message-ID-Hash: A26WOGOIX45K5ZBZVAC66H66APHZ42CQ
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: willy@infradead.org, jack@suse.cz, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A26WOGOIX45K5ZBZVAC66H66APHZ42CQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V6. Only change since V5 is that I changed order of WAKE_NEXT
and WAKE_ALL in comments too.

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
