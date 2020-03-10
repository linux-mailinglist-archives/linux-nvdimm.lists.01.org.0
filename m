Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7618081C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 20:31:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5B5810FC362D;
	Tue, 10 Mar 2020 12:32:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 805F010FC3628
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 12:32:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f5so13108276ilq.5
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=Auk/J/am7PnSkti7DnDeBTBkoI7EdkOeiXxOafA83iFtNlXEfJCh8HA0llJSykN0lU
         F3K3PX0+eGlrLpw9xVldfbGWlBeibwiL4+JP4oW3J6fT8IYoEUYX6QU+hSAzqc2x9YAS
         wcqf5w4LictNkY4z6rP056PjahcGRfLxvhsqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=GtAnntPcUfY0bsQat9bwY6U9s8+g5Ig678j8WeFU3DzJW+LRfkj6A0D+KIuZxszaFN
         YtKy89PE3N4xvCIQbFGCTUpj1nuxXGRYegp5syqedQXdf+WRqc3DoYtd/C8+EVdfAhPh
         whRTe6nkMUvfSU7ZOf8j32NsRuy8iJcPbg7losEpLllbRsXSR3apIqJCuUTIRlGMFUZk
         3Rntza1iKrkpTosa59teWShkE9Xv15cKpD2CvTNuzYNtuCi+6yxNavDhjoMjDEIoxzZp
         Tq2yJe5HffWZeZCzJ/mhED/v8Rk0ooWEPMoABcksWQCeVYZpQf4zENclWDJzYAbH891u
         S+zQ==
X-Gm-Message-State: ANhLgQ1W2uYA5u/3W0p3ujh2GsisEJ2DHuV3h8bXEDUgUFFCQV/DYyXS
	S4t4FhmsFZcyTA4ciGR0/7l9qgMJ8lAxD8M5PBmxqQ==
X-Google-Smtp-Source: ADFU+vsFfd6CjN4MRb2Z8XflZdOXGt54+OVcpgTdjMhSBiJTAUfuWfnL1e0wV+iTRlceDUTwZKIzKC3VAbxB+0sXKGs=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr21752506ilj.174.1583868715742;
 Tue, 10 Mar 2020 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-12-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-12-vgoyal@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 Mar 2020 20:31:44 +0100
Message-ID: <CAJfpegu5HMg2BnBsfSEWOv7K_0KjchntZ9q4oOvxzYLjOEBF3g@mail.gmail.com>
Subject: Re: [PATCH 11/20] fuse: implement FUSE_INIT map_alignment field
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: FEZXOMEFNM2YZNGDRNH3AW3JIIXQQ2BO
X-Message-ID-Hash: FEZXOMEFNM2YZNGDRNH3AW3JIIXQQ2BO
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FEZXOMEFNM2YZNGDRNH3AW3JIIXQQ2BO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> constraints via the FUST_INIT map_alignment field.  Parse this field and
> ensure our DAX mappings meet the alignment constraints.
>
> We don't actually align anything differently since our mappings are
> already 2MB aligned.  Just check the value when the connection is
> established.  If it becomes necessary to honor arbitrary alignments in
> the future we'll have to adjust how mappings are sized.
>
> The upshot of this commit is that we can be confident that mappings will
> work even when emulating x86 on Power and similar combinations where the
> host page sizes are different.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
