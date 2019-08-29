Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781ABA0F9B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 04:35:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4662720215F7A;
	Wed, 28 Aug 2019 19:36:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 360642020D30B
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 19:36:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c7so1953762otp.1
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wfTV1sStBn+3oJvyocwXxVuTvDK+XrmYeaZM0ov1ANE=;
 b=AxgH+OVR/WaFlGKGUPxkMnMhT44LFQW/ZcGpGMajOeqxY7i/xNVV37R6yvPksB2fJn
 Nqqk/JCfIukyClCP+4XWBMijaSrrvBP6xQw6KoXp9koeeqOx0F1TU8T+vJHg5PobhAIy
 a012S87QOuYlQJynV4JwXNcvQqu7yq/0HKmLXCRU5ztyPzRgxyThVATWCdDot2bR70x4
 pTR+GuU+AHoRhblbGvD/vdYL2wwI/bDsQcaHdmiquE+X6I6kzY3du+f6MzfVbBOaDsMs
 wX1/eXR/7LJ3weSFj7gST0aZ1j/VpftLytiK2jRio3N2yD8ljpujUt64vJEE53o3kX9k
 FHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wfTV1sStBn+3oJvyocwXxVuTvDK+XrmYeaZM0ov1ANE=;
 b=YZbnh6Zt+UWzyRt4MOaMlazhEpdMtWO+NUxLQZ07yyh79JskzBnBVuxnnVlUZ6OH8Q
 +ysS4vujZgXGDaf1OmtB/T6YkO5+feyAy3xM+Fg2w7THwfebmSmwGRrLmXMxXQ0bYqCe
 r0chdGoiJge4gDisBdXR5DhjS32Q3NTPl912BGQ1aNqSHYu4rj1LIxBkeIbeyEgHFHDy
 NRFJTbonbvozDS1Wb64rs71ekREKNvcedSfNS5tOvPCkleZcGXcdXAH4JtzDzBghGomP
 riBiBKOOuFjfvDXoUuU5uGU+cGIIjkVRszzdHqtsM84bvFuFUr2oT8027up6lXpb+MhX
 un9g==
X-Gm-Message-State: APjAAAV6x1H8Y309YPlFhMlMTqK2VdqOCZiYV2a+1Wi8M6mqueM4vOnj
 Pa0OlJg5NCBkZPu8X3gvoLBOiepU1o4IwezXHp4n9Q==
X-Google-Smtp-Source: APXvYqyTMdRPw4kdO2NiXD2MWNyfWOEhoTR+okN4Y1uhyisUm5rhgF4xYh9ck/9pZWkRGJTLLUeJaoE42WZfIPUQEYA=
X-Received: by 2002:a05:6830:1e05:: with SMTP id
 s5mr5449141otr.247.1567046098114; 
 Wed, 28 Aug 2019 19:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
In-Reply-To: <20190829001735.30289-4-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 28 Aug 2019 19:34:47 -0700
Message-ID: <CAPcyv4gB-2hkPM=zKCigpDAUxQbzWFVRmZ=UnTF0wsBW3-nmsQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Steve Scargall <steve.scargall@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 5:17 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a --continue option to ndctl-create-namespaces to allow the creation
> of as many namespaces as possible, that meet the given filter
> restrictions.
>
> The creation loop will be aborted if a failure is encountered at any
> point.
>
> Link: https://github.com/pmem/ndctl/issues/106
> Reported-by: Steve Scargal <steve.scargall@intel.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  .../ndctl/ndctl-create-namespace.txt          |  7 ++++++
>  ndctl/namespace.c                             | 25 +++++++++++++++----
>  2 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
> index c9ae27c..55a8581 100644
> --- a/Documentation/ndctl/ndctl-create-namespace.txt
> +++ b/Documentation/ndctl/ndctl-create-namespace.txt
> @@ -215,6 +215,13 @@ include::xable-region-options.txt[]
>  --bus=::
>  include::xable-bus-options.txt[]
>
> +-c::
> +--continue::
> +       Do not stop after creating one namespace. Instead, greedily create as

I like the "greedy" terminology here because it makes the option seem
a bit off-putting. "Do you really want to be greedy?"

> +       many namespaces as possible within the given --bus and --region filter
> +       restrictions. This will abort if any creation attempt results in an
> +       error.

Hmm, should "--continue --force" override that policy?

Otherwise this looks good to me.

> +
>  include::../copyright.txt[]
>
>  SEE ALSO
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index af20a42..8d6b249 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -41,6 +41,7 @@ static struct parameters {
>         bool do_scan;
>         bool mode_default;
>         bool autolabel;
> +       bool greedy;
>         const char *bus;
>         const char *map;
>         const char *type;
> @@ -114,7 +115,9 @@ OPT_STRING('t', "type", &param.type, "type", \
>  OPT_STRING('a', "align", &param.align, "align", \
>         "specify the namespace alignment in bytes (default: 2M)"), \
>  OPT_BOOLEAN('f', "force", &force, "reconfigure namespace even if currently active"), \
> -OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels")
> +OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels"), \
> +OPT_BOOLEAN('c', "continue", &param.greedy, \
> +       "continue creating namespaces as long as the filter criteria are met")
>
>  #define CHECK_OPTIONS() \
>  OPT_BOOLEAN('R', "repair", &repair, "perform metadata repairs"), \
> @@ -1365,8 +1368,11 @@ static int do_xaction_namespace(const char *namespace,
>                                 rc = namespace_create(region);
>                                 if (rc == -EAGAIN)
>                                         continue;
> -                               if (rc == 0)
> -                                       *processed = 1;
> +                               if (rc == 0) {
> +                                       (*processed)++;
> +                                       if (param.greedy)
> +                                               continue;
> +                               }
>                                 return rc;
>                         }
>                         ndctl_namespace_foreach_safe(region, ndns, _n) {
> @@ -1427,9 +1433,15 @@ static int do_xaction_namespace(const char *namespace,
>                 /*
>                  * Namespace creation searched through all candidate
>                  * regions and all of them said "nope, I don't have
> -                * enough capacity", so report -ENOSPC
> +                * enough capacity", so report -ENOSPC. Except during
> +                * greedy namespace creation using --continue as we
> +                * may have created some namespaces already, and the
> +                * last one in the region search may preexist.
>                  */
> -               rc = -ENOSPC;
> +               if (param.greedy && (*processed) > 0)
> +                       rc = 0;
> +               else
> +                       rc = -ENOSPC;
>         }
>
>         return rc;
> @@ -1487,6 +1499,9 @@ int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
>                 rc = do_xaction_namespace(NULL, ACTION_CREATE, ctx, &created);
>         }
>
> +       if (param.greedy)
> +               fprintf(stderr, "created %d namespace%s\n", created,
> +                       created == 1 ? "" : "s");
>         if (rc < 0 || (!namespace && created < 1)) {
>                 fprintf(stderr, "failed to %s namespace: %s\n", namespace
>                                 ? "reconfigure" : "create", strerror(-rc));
> --
> 2.20.1
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
