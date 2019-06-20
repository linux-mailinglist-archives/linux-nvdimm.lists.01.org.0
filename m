Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7B4CB4B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 11:49:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0044821A070B6;
	Thu, 20 Jun 2019 02:49:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9B84E21A09130
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 02:49:22 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 02:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; d="scan'208";a="170827607"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2019 02:49:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1hdth2-000C6R-F3; Thu, 20 Jun 2019 17:49:20 +0800
Date: Thu, 20 Jun 2019 17:48:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: [linux-nvdimm:libnvdimm-for-next 4/15]
 drivers/nvdimm/virtio_pmem.c:61:9: sparse: sparse: incompatible types in
 comparison expression (different base types):
Message-ID: <201906201741.FD4FeYGb%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Cornelia Huck <cohuck@redhat.com>, kbuild-all@01.org,
 Yuval Shaia <yuval.shaia@oracle.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
head:   3b6047778c09037615e7b919c922081ef1a37a7f
commit: 5990fce9c50eae1261a52df1488d04a47f4cfca7 [4/15] virtio-pmem: Add virtio pmem driver
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 5990fce9c50eae1261a52df1488d04a47f4cfca7
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/nvdimm/virtio_pmem.c:61:9: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/nvdimm/virtio_pmem.c:61:9: sparse:    restricted __le64 *
>> drivers/nvdimm/virtio_pmem.c:61:9: sparse:    unsigned long long *
   drivers/nvdimm/virtio_pmem.c:63:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/nvdimm/virtio_pmem.c:63:9: sparse:    restricted __le64 *
   drivers/nvdimm/virtio_pmem.c:63:9: sparse:    unsigned long long *

vim +61 drivers/nvdimm/virtio_pmem.c

    31	
    32	static int virtio_pmem_probe(struct virtio_device *vdev)
    33	{
    34		struct nd_region_desc ndr_desc = {};
    35		int nid = dev_to_node(&vdev->dev);
    36		struct nd_region *nd_region;
    37		struct virtio_pmem *vpmem;
    38		struct resource res;
    39		int err = 0;
    40	
    41		if (!vdev->config->get) {
    42			dev_err(&vdev->dev, "%s failure: config access disabled\n",
    43				__func__);
    44			return -EINVAL;
    45		}
    46	
    47		vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
    48		if (!vpmem) {
    49			err = -ENOMEM;
    50			goto out_err;
    51		}
    52	
    53		vpmem->vdev = vdev;
    54		vdev->priv = vpmem;
    55		err = init_vq(vpmem);
    56		if (err) {
    57			dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
    58			goto out_err;
    59		}
    60	
  > 61		virtio_cread(vpmem->vdev, struct virtio_pmem_config,
    62				start, &vpmem->start);
    63		virtio_cread(vpmem->vdev, struct virtio_pmem_config,
    64				size, &vpmem->size);
    65	
    66		res.start = vpmem->start;
    67		res.end   = vpmem->start + vpmem->size - 1;
    68		vpmem->nd_desc.provider_name = "virtio-pmem";
    69		vpmem->nd_desc.module = THIS_MODULE;
    70	
    71		vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
    72							&vpmem->nd_desc);
    73		if (!vpmem->nvdimm_bus) {
    74			dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
    75			err = -ENXIO;
    76			goto out_vq;
    77		}
    78	
    79		dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
    80	
    81		ndr_desc.res = &res;
    82		ndr_desc.numa_node = nid;
    83		ndr_desc.flush = async_pmem_flush;
    84		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
    85		set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
    86		nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
    87		if (!nd_region) {
    88			dev_err(&vdev->dev, "failed to create nvdimm region\n");
    89			err = -ENXIO;
    90			goto out_nd;
    91		}
    92		nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
    93		return 0;
    94	out_nd:
    95		nvdimm_bus_unregister(vpmem->nvdimm_bus);
    96	out_vq:
    97		vdev->config->del_vqs(vdev);
    98	out_err:
    99		return err;
   100	}
   101	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
