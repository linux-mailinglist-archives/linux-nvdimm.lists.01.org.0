Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679D132CFE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 18:29:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DCF3310097E0D;
	Tue,  7 Jan 2020 09:32:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E69510097E09
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 09:32:48 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id d7so717319otf.5
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpnN1Qc4KdEV6DUorcFDZqPBu69hsxGWQC1ntViNntM=;
        b=dp9Ew5g9lYMzS264P2PLif4UMUWCdr0VxT5zi507EuXBe/GMDwox3up8SHuWHmyP4T
         9aWUzrwZZDBJ6e5ckod8FgFlwxFutDfkUszACYcESvmIW3XIRV87+SRZuMXXtbIyoQnr
         36d1hgke3/f7kFbjgfq67/qmBh4nPMy73TncwwP+OrJFn+zy/Yh/gSHc+AM6QsIpzji/
         ogpxDvLch5e5wIwoi8Ss33m+jQRUpS2XaDudai5FQj1dEvDxONyce8hVVSaWIe/Ykdba
         T3kDRLJpPGsYI1zX26cb0kYkqz4k+sQ2qT01KO03k9YXXRxw4xHsrGJs2VcqvSfUTgmk
         GPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpnN1Qc4KdEV6DUorcFDZqPBu69hsxGWQC1ntViNntM=;
        b=fwbAkCWylxdKKa9gi5LAeoTiTKf8K8g929NjaXLvryOnQn2PpHC04CHEzOU99qBFma
         GobaEN58IEAzR9uCX3qiF6qFxOiZllv6m6naret6e+aWNU+/z9T9iNx83NRIPEgVoNYx
         oZOqvbV6tjrqyrGVvnCnAwidcAHBj7LTXmLUPJziYObauK4tSlTyUbiQu1LUBzKeg/wT
         doQF5ixiZLEfAI+oP3PHqN5PaR3jStaSBgbwfZyK0tVuV0z+39U6CS+LYSIV+m2yRJZe
         JRZzeV+Az2ayd6zT+iBrj/NUCDDMtsxELurKP+MxeQiy+h6E1D1z+Tines7AcsZ7fiMq
         J70g==
X-Gm-Message-State: APjAAAX1Sl5N9uYLvHYGBAf6sB6jByekmYr3S4FfoN7SYGna8VB5NdBz
	ADCfEb34ZEw5a7g/BhTJM7lN2JkJU0tBVbWUxCViCw==
X-Google-Smtp-Source: APXvYqwKo20I0n5xbnSQdFnOTztBVQs28N/hQCqru2njBZbSH8O8dd6qzeslV9G/Fnx0Sql1iukKgVWgGb0ZcMiHKVw=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr817574otm.247.1578418168350;
 Tue, 07 Jan 2020 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-2-vgoyal@redhat.com> <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com> <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com> <20200107170731.GA472641@magnolia>
In-Reply-To: <20200107170731.GA472641@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 09:29:17 -0800
Message-ID: <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: ILS7E7YM2QHZ3OGDP3VQ652TXJ3ZV6S3
X-Message-ID-Hash: ILS7E7YM2QHZ3OGDP3VQ652TXJ3ZV6S3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ILS7E7YM2QHZ3OGDP3VQ652TXJ3ZV6S3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > implementation to expect the block-device to be available.
> > > > >
> > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > dax_device could be dynamically created to represent the subset range
> > > > > indicated by the block-device partition. That would open up more
> > > > > cleanup opportunities.
> > > >
> > > > Hi Dan,
> > > >
> > > > After a long time I got time to look at it again. Want to work on this
> > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > >
> > > > I am not sure I understand the requirements fully. I see that right now
> > > > dax_device is created per device and all block partitions refer to it. If
> > > > we want to create one dax_device per partition, then it looks like this
> > > > will be structured more along the lines how block layer handles disk and
> > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > including partition 0). That probably means state belong to whole device
> > > > will be in common structure say dax_device_common, and per partition state
> > > > will be in dax_device and dax_device can carry a pointer to
> > > > dax_device_common.
> > > >
> > > > I am also not sure what does it mean to partition dax devices. How will
> > > > partitions be exported to user space.
> > >
> > > Dan, last time we talked you agreed that partitioned dax devices are
> > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > devices and then remove them after a cycle or two?
> >
> > That does seem a better plan than trying to force partition support
> > where it is not needed.
>
> Question: if one /did/ have a partitioned DAX device and used kpartx to
> create dm-linear devices for each partition, will DAX still work through
> that?

The device-mapper support will continue, but it will be limited to
whole device sub-components. I.e. you could use kpartx to carve up
/dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
