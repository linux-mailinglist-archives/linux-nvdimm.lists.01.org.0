Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1836DD7E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Apr 2021 18:51:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B843B100EF26A;
	Wed, 28 Apr 2021 09:51:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EA5C100EF264
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619628660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E/fqWNE7LQ7FhXknXyJchDB3GzeF4lW6wfnQ7hJxAE0=;
	b=X4AV2ky68x93wybc+D8eqogxoP5QCgL7nUWae1xbeuu/cHR6sd8CdkDVep7AAC+LnMSYHN
	2A3xdlX1IdiVa1+WsYWXCxYLtO0Q0Wc1FEFqY6OACS2ICTBBxLHRKknxWbWJ6IdSdsRd3+
	49p6kLYyEcFhwVguVAZOd8061X7OzsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171--qo-T9cBO96lHXeEvi4-qw-1; Wed, 28 Apr 2021 12:50:57 -0400
X-MC-Unique: -qo-T9cBO96lHXeEvi4-qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F32A8031FA;
	Wed, 28 Apr 2021 16:50:50 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C74981007610;
	Wed, 28 Apr 2021 16:50:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 50E2C220BCF; Wed, 28 Apr 2021 12:50:49 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	dan.j.williams@intel.com
Subject: [PATCH v5 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date: Wed, 28 Apr 2021 12:50:37 -0400
Message-Id: <20210428165040.1856202-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: EBM7P4AUBUTRFBZNSCJDYD5D3R5CVA7B
X-Message-ID-Hash: EBM7P4AUBUTRFBZNSCJDYD5D3R5CVA7B
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, jack@suse.cz, willy@infradead.org, slp@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EBM7P4AUBUTRFBZNSCJDYD5D3R5CVA7B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This is V5 of patches. Posted V4 here.

https://lore.kernel.org/linux-fsdevel/20210423130723.1673919-1-vgoyal@redhat.com/

Changes since V4:

- Changed order of WAKE_NEXT and WAKE_ALL entries in enum. (Matthew Wilcox).

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
