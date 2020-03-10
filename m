Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A2180A5F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 22:27:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E0E510FC3633;
	Tue, 10 Mar 2020 14:28:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E4B810FC3626
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583875638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKXeApzEIrganyKyVwOYKeqr2I1X5zY93j0vYEaVCME=;
	b=McSFDTcmYzmlQSPZAYlptwPSPbLpNSLRe4bjSuDARy0IEVDPTHVDs7IY/FJpa53SDV4dh1
	RrZXtyzkBSGVMdyVLPrBtl7AS/x5FUViUnUZHT9YxuUjTEQjQKkLltl35nxwJ5dE7eNjUp
	JJKvX22mvGUIsA+NRT5E9OtPKV4UpTA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-IbcaUfJhPnKtSWNu-ksjbw-1; Tue, 10 Mar 2020 17:27:17 -0400
X-MC-Unique: IbcaUfJhPnKtSWNu-ksjbw-1
Received: by mail-qt1-f198.google.com with SMTP id c13so10050747qtq.23
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elF36Gh6wAO43EXQWi3veY++EdOPHWUl7a5YAiXhFTQ=;
        b=jD/Kulqtr1eEdDktJlEQBs4Yf233/LXPTbZ07Gg73D148CgBdi4FXHTH3eMnQ1+B/I
         YhHi7KDzU/fYQ3zXi/Ts/jNIYM8+XpI7v3OFD7Pk82Gw6DR5m5LSJQKsmvMdp0ydTIp/
         S2n8Uqt/aaVaabZt3sh8OD8TyD9Waxm7qBWsPOl2bGgTadubN1UIXT3TaAWYioJ9lf0l
         GaW9UAKp35J2ErUuxQ9cW0J7qIgFI25Y4Y+maYEqogTINKRloh2/+oVdgQ3Jq64Mh+oP
         UQs1MueOHpvQQgTam+DeRKAblM4PUo7ELj0WPj2KsQHV4jSKV7Z5raGYRJwIKHLZTYgI
         5Irw==
X-Gm-Message-State: ANhLgQ1kNIfY71OnsgY3Z4QtPfAjZeqdyB4CvIWhjiEGbucET67TZyd7
	UJ/wergc3vw3sHWK8F4YsXifwPlw5Pfp+sGCLoAe/ksZwaakc/zlqhYyHG6xpDl+s0bbUr/gdhL
	UedYy6hyKEsrOk1FQasPX
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535573qka.211.1583875636484;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXf2G2CIG42koICoLhPiploL8mRnMRgCVqT/plH2Fo1ASYnuHMzPvSDT2uyk6rvt8fR12jmg==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr21535545qka.211.1583875636149;
        Tue, 10 Mar 2020 14:27:16 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id x51sm3774837qtj.82.2020.03.10.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:27:14 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:27:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310172603-mutt-send-email-mst@kernel.org>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
 <20200310071043-mutt-send-email-mst@kernel.org>
 <20200310184720.GD38440@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310184720.GD38440@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: T3Y5WZI7XXEAA5TRT4QVZFVG62KME6XD
X-Message-ID-Hash: T3Y5WZI7XXEAA5TRT4QVZFVG62KME6XD
X-MailFrom: mst@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>, kbuild test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T3Y5WZI7XXEAA5TRT4QVZFVG62KME6XD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2020 at 02:47:20PM -0400, Vivek Goyal wrote:
> On Tue, Mar 10, 2020 at 07:12:25AM -0400, Michael S. Tsirkin wrote:
> [..]
> > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > +			      struct virtio_shm_region *region, u8 id)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > > +	u8 bar;
> > > +	u64 offset, len;
> > > +	phys_addr_t phys_addr;
> > > +	size_t bar_len;
> > > +	int ret;
> > > +
> > > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > +		return false;
> > > +	}
> > > +
> > > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > > +	if (ret < 0) {
> > > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > > +			__func__);
> > > +		return false;
> > > +	}
> > > +
> > > +	phys_addr = pci_resource_start(pci_dev, bar);
> > > +	bar_len = pci_resource_len(pci_dev, bar);
> > > +
> > > +        if (offset + len > bar_len) {
> > > +                dev_err(&pci_dev->dev,
> > > +                        "%s: bar shorter than cap offset+len\n",
> > > +                        __func__);
> > > +                return false;
> > > +        }
> > > +
> > 
> > Something wrong with indentation here.
> 
> Will fix all indentation related issues in this patch.
> 
> > Also as long as you are validating things, it's worth checking
> > offset + len does not overflow.
> 
> Something like addition of following lines?
> 
> +       if ((offset + len) < offset) {
> +               dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
> +                       __func__);
> +               return false;
> +       }
> 
> Vivek

That should do it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
