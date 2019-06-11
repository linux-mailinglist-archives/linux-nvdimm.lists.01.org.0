Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2A53D02D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Jun 2019 17:05:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DD9721295B1B;
	Tue, 11 Jun 2019 08:05:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=msnitzer@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4E3D521289DB8
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 08:05:18 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F49930BBE98;
 Tue, 11 Jun 2019 15:04:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DB05DA2E;
 Tue, 11 Jun 2019 15:04:28 +0000 (UTC)
Date: Tue, 11 Jun 2019 11:04:27 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v11 4/7] dm: enable synchronous dax
Message-ID: <20190611150427.GA29288@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
 <20190610090730.8589-5-pagupta@redhat.com>
 <20190610192803.GA29002@redhat.com>
 <1206355816.34396746.1560258658768.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1206355816.34396746.1560258658768.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 11 Jun 2019 15:05:18 +0000 (UTC)
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
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, linux-nvdimm@lists.01.org,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
 stefanha@redhat.com, imammedo@redhat.com, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
 darrick wong <darrick.wong@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 11 2019 at  9:10am -0400,
Pankaj Gupta <pagupta@redhat.com> wrote:

> Hi Mike,
> 
> Thanks for the review Please find my reply inline.
> 
> > 
> > dm_table_supports_dax() is called multiple times (from
> > dm_table_set_restrictions and dm_table_determine_type).  It is strange
> > to have a getter have a side-effect of being a setter too.  Overloading
> > like this could get you in trouble in the future.
> > 
> > Are you certain this is what you want?
> 
> I agree with you.
> 
> > 
> > Or would it be better to refactor dm_table_supports_dax() to take an
> > iterate_devices_fn arg and have callers pass the appropriate function?
> > Then have dm_table_set_restrictions() caller do:
> > 
> >      if (dm_table_supports_dax(t, device_synchronous, NULL))
> >                set_dax_synchronous(t->md->dax_dev);
> > 
> > (NULL arg implies dm_table_supports_dax() refactoring would take a int
> > *data pointer rather than int type).
> > 
> > Mike
> > 
> 
> I am sending below patch as per your suggestion. Does it look
> near to what you have in mind?

Yes, it does.. just one nit I noticed inlined below.

> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 350cf0451456..8d89acc8b8c2 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c

...

> @@ -1910,8 +1919,13 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>         }
>         blk_queue_write_cache(q, wc, fua);
> 
> -       if (dm_table_supports_dax(t, PAGE_SIZE))
> +       if (dm_table_supports_dax(t, device_supports_dax, &page_size)) {
> +

No need for an empty newline here ^

>                 blk_queue_flag_set(QUEUE_FLAG_DAX, q);
> +               if (dm_table_supports_dax(t, device_synchronous, NULL))
> +                       set_dax_synchronous(t->md->dax_dev);
> +       }
>         else
>                 blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
> 

Thanks,
Mike
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
