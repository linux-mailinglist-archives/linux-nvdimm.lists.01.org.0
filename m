Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061613780B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 21:39:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5685210097DDF;
	Fri, 10 Jan 2020 12:42:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D011210097DDC
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1578688740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj4IKAYX3opVay+zOjDOMD4FkgngWu+kCGGgbKH+hWw=;
	b=QL8Ay3hrq1LZd58KuRJN4SrkbfiaeZIYd5JLBsDMcVugZg/DXnmLGYMLWT9/+S0EKvplw+
	ByXUssRKMDZKM9CuahJZfaA1vdP0/Vq8uUGaymW/Lbb+6g2eGNyF9N+4Z63oimI2mZpkvF
	HEO9defS2GWlh7cg5ca0HxIYXTtHgzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-kKxxdPhsPBGsEk-kfwlwEw-1; Fri, 10 Jan 2020 15:38:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AF371800D78;
	Fri, 10 Jan 2020 20:38:56 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A58C86CD3;
	Fri, 10 Jan 2020 20:38:56 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size validation arch dependent
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 10 Jan 2020 15:38:54 -0500
In-Reply-To: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com> (Aneesh
	Kumar K. V.'s message of "Wed, 8 Jan 2020 12:22:14 +0530")
Message-ID: <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: kKxxdPhsPBGsEk-kfwlwEw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: TQJGQKWEMR6PCZ5JDJEAB67KJFGLAC3D
X-Message-ID-Hash: TQJGQKWEMR6PCZ5JDJEAB67KJFGLAC3D
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TQJGQKWEMR6PCZ5JDJEAB67KJFGLAC3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Aneesh,

After applying this patch series, several of my namespaces no longer
enumerate:

Before:

# ndctl list
[
  {
    "dev":"namespace0.2",
    "mode":"sector",
    "size":106541672960,
    "uuid":"ea1122b2-c219-424c-b09c-38a6e94a1042",
    "sector_size":512,
    "blockdev":"pmem0.2s"
  },
  {
    "dev":"namespace0.1",
    "mode":"fsdax",
    "map":"dev",
    "size":10567548928,
    "uuid":"68b6746f-481a-4ae6-80b5-71d62176606c",
    "sector_size":512,
    "align":4096,
    "blockdev":"pmem0.1"
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":52850327552,
    "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
    "sector_size":512,
    "align":2097152,
    "blockdev":"pmem0"
  }
]

After:

# ndctl list
[
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":52850327552,
    "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
    "sector_size":512,
    "align":2097152,
    "blockdev":"pmem0"
  }
]

I won't have time to dig into it this week, but I wanted to mention it
before Dan merged these patches.

I'll follow up next week with more information.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
