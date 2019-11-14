Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92900FC0BA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 08:26:39 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6C82100DC43E;
	Wed, 13 Nov 2019 23:28:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.64; helo=hqemgate15.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C5E2100DC43D
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 23:28:09 -0800 (PST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dcd01ab0000>; Wed, 13 Nov 2019 23:26:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 23:26:36 -0800
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 23:26:36 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 07:26:35 +0000
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
 <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
 <20191114072354.GA26448@lst.de>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <588a955d-0750-b6db-738a-7556704fa894@nvidia.com>
Date: Wed, 13 Nov 2019 23:26:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114072354.GA26448@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1573716395; bh=bAjMhffZlUOOQ4J77AH0Tz30434cSCz8DX1xgdnGyZo=;
	h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=VPIkac5L735bU9bvuVXOajHcI4VxRWpWKyWtIEWF/mc2BDNfPoypitaHjXmKC1Epg
	 +D3HzQ4S7/khVD+3f9UwNYzRG6XNLXh3dLzGjj0AznLRQBu8lJXhK/t/nr0/g33v3i
	 CWoCOPGILs+u7fpkSz4rSibyd8ZmGuv1LI0qML6E7ELjNq9tSPkjt45w/+Ky5DjUEp
	 UCw5HnA6k92XlD00WuxlgYgWz9mC4SoOIrGvvRBlfqhUtrv1fFMjgcj7hSK8RksdUi
	 58PpdVwukn3k+GwdElgFuIZEgabCZF9OTjH1YhowQm1PHnzrnp1HJqIo25LRhlCBlx
	 4OWwzN+jbwWvw==
Message-ID-Hash: FH34HQG53V5HK7MRUXCNGF5R5MJ62P2G
X-Message-ID-Hash: FH34HQG53V5HK7MRUXCNGF5R5MJ62P2G
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FH34HQG53V5HK7MRUXCNGF5R5MJ62P2G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/13/19 11:23 PM, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 04:47:38PM -0800, Dan Williams wrote:
>>> Got it. This will appear in the next posted version of my "mm/gup: track
>>> dma-pinned pages: FOLL_PIN, FOLL_LONGTERM" patchset.
>>
>> Thanks!
> 
> John - can you please send a small series just doing the zone device
> patches rework?  That way we can review it separately and maybe even get
> it into 5.5.
> 

Sure.


thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
