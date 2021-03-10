Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D5333607
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 07:54:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45D2A100EB847;
	Tue,  9 Mar 2021 22:54:32 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0ECA100EC1E7
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 22:54:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68A4768B05; Wed, 10 Mar 2021 07:54:25 +0100 (CET)
Date: Wed, 10 Mar 2021 07:54:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region
 read-only
Message-ID: <20210310065425.GA1794@lst.de>
References: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 2MHCF6RDSLJDAJUYA3E3GSXGWHAXESUV
X-Message-ID-Hash: 2MHCF6RDSLJDAJUYA3E3GSXGWHAXESUV
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2MHCF6RDSLJDAJUYA3E3GSXGWHAXESUV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Question on the pre-existing code: given that nvdimm_check_and_set_ro is
the only caller of set_disk_ro for nvdimm devices, we'll also get
the message when initially setting up any read-only disk.  Is that
intentional?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
