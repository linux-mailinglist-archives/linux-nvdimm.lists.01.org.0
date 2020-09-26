Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F02279636
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Sep 2020 04:22:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77FA114DE787B;
	Fri, 25 Sep 2020 19:22:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3EFA14DE787A
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 19:22:35 -0700 (PDT)
Received: from X1 (unknown [104.245.68.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D3A5120866;
	Sat, 26 Sep 2020 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601086955;
	bh=yONBZOLFobn/XfNSqbInd73Y3EF/XNd7uGysPjXX+BA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TK19VAMIz0cAxC09t8GSQfxw5Vbk8/p15wK/uEoNz2F4UaGxxlh6VJwIdrfeD7wfN
	 3RE94dfL12JijaAtruhBkmaewy50WEfL9Dpgn/Quk90C5ZbIiq563PKwsHz6PnUdip
	 9oNuqX1UJ8gC0F9Dk7JkdXMqZEcbuNlaZ6RsFGxs=
Date: Fri, 25 Sep 2020 19:22:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 15/17] device-dax: add an 'align' attribute
Message-Id: <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
In-Reply-To: <160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
	<160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: G24QVTQSGVZVQZFY5QYQTRWRCEWK2Z3F
X-Message-ID-Hash: G24QVTQSGVZVQZFY5QYQTRWRCEWK2Z3F
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G24QVTQSGVZVQZFY5QYQTRWRCEWK2Z3F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2020 12:13:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Introduce a device align attribute.  While doing so, rename the region
> align attribute to be more explicitly named as so, but keep it named as
> @align to retain the API for tools like daxctl.
> 
> Changes on align may not always be valid, when say certain mappings were
> created with 2M and then we switch to 1G.  So, we validate all ranges
> against the new value being attempted, post resizing.
> 
> Link: https://lkml.kernel.org/r/159643105944.4062302.3131761052969132784.stgit@dwillia2-desk3.amr.corp.intel.com
> Link: https://lore.kernel.org/r/20200716172913.19658-3-joao.m.martins@oracle.com
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>

The signoff chain implies that this was From:Joao.  Please clarify?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
