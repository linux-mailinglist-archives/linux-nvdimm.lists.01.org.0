Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2208001D
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 20:19:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D894A2130D7C8;
	Fri,  2 Aug 2019 11:21:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 495A021306CFF
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 11:21:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c15so2103868oic.3
 for <linux-nvdimm@lists.01.org>; Fri, 02 Aug 2019 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Lb5cDyYJxTogVnnuPnyK7xdeZ+ybhz44+AI/OcJZRc=;
 b=oyc0FfL8uJFWgdzyL5/IjF2uMUanvVyPBapbJ7eRH5UnYxaPz2XwqRugBg5V/BnbSO
 D0YmB7GsrC7DqDCrNdUsU8nXx6sZF7LtetIHFAYrNX7f0vbqu8tHkDZFNv/r2cxXNvj9
 tCjEBaFxAnrUB9sQiozeYuzlogGKp4GL27npolH2DnNpjiR8aSm9/Ix620BAc/f8iE29
 q+BLGJGkyzeLYD2gW4D1t5OiFmToSiUTxzZoagQtLQDaefKrPIiXJhtKj5Onfq1T+C1x
 jr9Eo4CBCygSvrBEBR82BHHt7ziZb9I5Uf93NbQsWDA5Vm7vzo4joX2Uyp4ZHW4mrTRx
 1bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Lb5cDyYJxTogVnnuPnyK7xdeZ+ybhz44+AI/OcJZRc=;
 b=q86Pp24DZJg4F42VlqjNkxuPy/MhVusuEpWJSRMLpuP5itJqIAxNMzEWd4uDunM/UP
 Y7V5nni8dzgTXdC5tr8y/7XdGSwyMkxgsFkfcm5Jc4mBCH7wvURiaTNu/z/xoNLtOhPY
 olmakIAdiqqmv2xwcBR9PoIpMYJ7g9j2SBJninKVUC+yhu5dSuJGUnuzDspsu3UhbODb
 2jVauZr90I2G9ROHd6mc50Tr92hSbhTIrjtZJ2W2q8Gk/sQQLhEYevFot95vNoz7PR2Q
 UwA4Mv/vC9bqiVo5x6AAokby4/TOusGREqqAyb+TWJmBIBgC1NJrEwsxlUQb5C5K7q4y
 iA0w==
X-Gm-Message-State: APjAAAW/fMkYvwFyznS2gqmycK4bB+8kdjb79++2nl3oaYbWtG9tz83n
 t5Bf+kVkcriAjk1AZ3sbuRione7M4YOwCERVqINkZbVS82M=
X-Google-Smtp-Source: APXvYqyPX6O+QJhRm/kyjUm1oZLKEASHiqFNg4n72K2z4eB6HiRXyiqRJ3cAuVfsRPNF1qTWT3lbiqjupCZMwo1NBsI=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr3379540oih.73.1564769962791; 
 Fri, 02 Aug 2019 11:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156426356654.531577.6142389862764297120.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c6026e16692b0aae2b8fdef1085940259d40de93.camel@intel.com>
In-Reply-To: <c6026e16692b0aae2b8fdef1085940259d40de93.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Aug 2019 11:19:11 -0700
Message-ID: <CAPcyv4h5YWF5hrX+B5iJrW95K03TFA+a2rsQPFtG=PqN8WgigQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v2 01/26] ndctl/dimm: Add 'flags' field to
 read-labels output
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 2, 2019 at 11:01 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
>
> On Sat, 2019-07-27 at 14:39 -0700, Dan Williams wrote:
> > Recent discussions on some platform implementations setting the LOCAL
> > bit in namespace labels makes it apparent that this field should be
> > decoded in the json representation.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  ndctl/dimm.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> > index b2b09b6aa9a2..8946dc74fe41 100644
> > --- a/ndctl/dimm.c
> > +++ b/ndctl/dimm.c
> > @@ -141,6 +141,11 @@ static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
> >                       break;
> >               json_object_object_add(jlabel, "nlabel", jobj);
> >
> > +             jobj = json_object_new_int64(le64_to_cpu(nslabel.flags));
>
> Should we print this in hex instead?

Ah, yes.

/me goes to check why he didn't do this finds that this support
arrives in the next patch that adds --human support to read-labels.

So it's there in "ndctl/dimm: Add --human support to read-labels"
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
