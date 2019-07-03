Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9C5E3A7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 14:17:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B674C212ACEC4;
	Wed,  3 Jul 2019 05:17:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 868C2212ACEBD
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hc324U3gAsxTQ/xr9GNXQHJJuTwkj9Ztqk5d0xFNlFU=; b=Xj2zv+NLMKqcrDj7CARx0zOVI
 jJK06jsuo+7e0kGWyVsxlo9JpCRcFvB70RUcxc76zUpG5U8ZMGyFvIObD6VE1TsfdpdgsvZhGdWFZ
 3vKAdB1dzqzis3/L2txNhzx46f8QXrWRy0dYKjBKiFxHq3dZAxgiQCItF9xKq7V/WZXyz+Pxa6gC9
 lxaJgQUtqqeiKyI1pjLnOiLEvaDiKkW/mQc6JeWowqfBpEQcuiPXAoV1PhCVx+RpVimMl2NcX+Q7n
 fDLBWQsDHhwFnZcYUCn75x+jq0vtuq8cF1nAbAOALi8y6bGYnc4QT8GquQ/xpHG8pqAEUvHzvSFVu
 a4VGSS+pA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hieCl-0000Gy-GK; Wed, 03 Jul 2019 12:17:43 +0000
Date: Wed, 3 Jul 2019 05:17:43 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190703121743.GH1729@bombadil.infradead.org>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Seema Pandit <seema.pandit@intel.com>, linux-nvdimm@lists.01.org,
 Boaz Harrosh <openosd@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> This fix may increase waitqueue contention, but a fix for that is saved
> for a larger rework. In the meantime this fix is suitable for -stable
> backports.

I think this is too big for what it is; just the two-line patch to stop
incorporating the low bits of the PTE would be more appropriate.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
